/* This creates a test plate with 

   By default, this file will create 5 sets of thumb
   holes for testing the following attributes:

     hand separation: 1   -> 5
     kerf:            0   -> 0.25
     screw offset:    1.5 -> 4
*/
$fn = 50;

n_rows       = 5;

rotation     = 10;
screw_radius = 1.5;

sep_step     = 1;    // Distance between caps (horizontally)
kerf_step    = 0.05;
offset_step  = 0.5;  // Screw offset (orthogonally from cap edge to center of screw)
offset_start = screw_radius;

key_size     = 19;
bezel_radius = 10;

translate([-30,0]) square(10, center=true);

rotate(90) difference() {
  bezel();
  for(i=[0:n_rows-1])
    translate([0,-1.75*key_size*i])
      thumbs(sep_step*i+1)
        cap(kerf_step*i, offset_step*i+offset_start);
  rotate(-90) translate([-12,28])
    text("αdox", font="Athelas:style=Bold");
}

module bezel() {
  max_x = key_size + (n_rows-1)*offset_step + offset_start + (n_rows*sep_step+1)/2;
  max_y = -1.5*key_size - (n_rows-1)*offset_step - offset_start;
  offset = rz_fun([max_x,max_y]);
  
  hull() for(x=[-offset[0],offset[0]]) for(y=[offset[1]-max_y,offset[1]-7*key_size])
    translate([x,y]) circle(bezel_radius, center=true);
}

module thumbs(separation=0) {
  translate([separation/2,0]) thumb() children();
  translate([-separation/2,0]) mirror() thumb() children();
}

module thumb() {
  rotate(rotation) translate([0.5*key_size,-0.75*key_size]) children();
}

module cap(kerf=0, screw_offset=0) {
  difference() {
    square([key_size,1.5*key_size], center=true);
    switch_hole(kerf);
  }
  translate([key_size/2+screw_offset,
             -0.75*key_size-screw_offset])
    circle(screw_radius, center=true);
}

module switch_hole(kerf=0) {
  hole_size    = 13.97;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.8128;

  union() {
    square(hole_size-kerf, center=true);
      translate([0, notch_offset]) {
        square([hole_size+2*notch_depth, notch_width], center=true);
      }
      translate([0, -notch_offset]) {
        square([hole_size+2*notch_depth, notch_width], center=true);
      }
  }
}

function rz_fun(p) = [p[0]*cos(rotation) - p[1]*sin(rotation),
                      p[0]*sin(rotation) + p[1]*cos(rotation)];