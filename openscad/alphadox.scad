// Reference:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn      = 10; // Increase the resolution for the small screw holes.
key_size = 19; // Distance between keys.

// User settings.
n_cols         = 6;
n_rows         = 4;
n_thumbs       = 2;
thumb_offset   = [-10, -30]; // Default Ergodox offset: [-10, -30]
thumb_rotation = 25;
bezel          = 5;
screw_d        = 2.1;

// Staggering of the columns, inside->out.
//
// For reference, the Ergodox stagger:
//   122.24766
//   120.97766
//   119.38
//   120.97766
//   124.15266
//   124.15266
stagger = [0, 2.5, 4, 2.5, -2, -2];

// For reference!
everything(true);

module everything(switch=false, teensy=false) {
  difference() {
    edge_cuts();
    screws() screw();

    if (!switch)
      keys(scale=true) square(18, center=true);
    else
      keys() switch(notch=false);

    if (teensy)
      translate([-35, 30]) teensy();
  }
}

module screws() {
  translate(thumb_offset)
    rotate(thumb_rotation)
      translate([-0.5*key_size, 0.75*key_size])
        children();

  translate([0.5*key_size, 1.5*key_size + (stagger[0]+stagger[1])/2])
    children();

  translate([1.5*key_size, -0.5*key_size + (stagger[1]+stagger[2])/2])
    children();

  translate([4.5*key_size, 1.5*key_size + (stagger[4]+stagger[5])/2])
    children();

  translate([4.5*key_size, -0.5*key_size + (stagger[4]+stagger[5])/2])
    children();
}

module edge_cuts() {
  // Thumb points starting from 12:00 and going counterclockwise.
  thumb_points = [
    for (point = [[-0.5*key_size,
                   2*key_size + bezel],
                  [(0.5-n_thumbs)*key_size - bezel,
                   2*key_size + bezel],
                  [(0.5-n_thumbs)*key_size - bezel,
                   -key_size - bezel]])
    thumb_offset + rz_fun(point, thumb_rotation)
  ];

  thumb_1 = rz_fun([
                    2*key_size + bezel],
                   thumb_rotation);
  thumb_2 = rz_fun([(0.5-n_thumbs)*key_size - bezel,
                    2*key_size + bezel],
                   thumb_rotation);

  max_x = (n_cols)*key_size + bezel;
  min_y = -1.5*key_size + min(stagger) - bezel;
  max_y = (n_rows-1.5)*key_size + max(stagger) + bezel;

  polygon([
    thumb_points[0],
    thumb_points[1],
    thumb_points[2],
    [(min_y - thumb_points[2][1])/tan(thumb_rotation) + thumb_points[2][0], min_y],
    [max_x, min_y],
    [max_x, max_y],
    [thumb_points[0][0], max_y],
  ]);
}

module keys(scale=false) {
  identity   = [1, 1];

  // Alphabet
  for (x=[0:n_cols-2])
    for (y=[0:2])
      translate([x*key_size, y*key_size+stagger[x]])
        children();

  // Bottom row
  for (x=[1:n_cols-1])
    translate([x*key_size, -key_size+stagger[x]])
      children();

  // Far column
  for (y=[0:n_rows-2])
    translate([(n_cols-0.75)*key_size, y*key_size+stagger[n_cols-1]])
      scale(scale ? [1.5, 1] : identity)
        children();

  // Thumb cluster
  translate(thumb_offset)
    rotate(thumb_rotation)
      for (i=[0:n_thumbs-1])
        translate([-i*key_size, 0]) {
          rotate(90) // The main thumb switches are mounted sideways
            scale(scale ? [2, 1] : identity)
              children();
          translate([0, 1.5*key_size])
            children();
        }
}

module switch(notch=true, kerf=0) {
  hole_size    = 13.9;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.8128;

  union() {
    square(hole_size-kerf, center=true);
    if (notch) {
      for (y=[-notch_offset,notch_offset])
        translate([0,y])
          square([hole_size+2*notch_depth, notch_width], center=true);
    }
  }
}

module screw() {
  circle(d=screw_d, center=true);
}

teensy_size = [18.0, 30.5];
module teensy() square(teensy_size, center=true);

// Computes post-rotation coordinates.
function rz_fun(p, r) = [p[0]*cos(r) - p[1]*sin(r),
                         p[0]*sin(r) + p[1]*cos(r)];