// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn          = 75;                  // Increase the resolution for the small screw holes.
key_size     = 19;                  // Distance between keys.
bezel        = 4;                   // Bezel size.

// User settings.
n_cols   = 10;  // Number of columns.
n_rows   = 4;  // Number of rows.
screw_d  = 3;  // Screw size.

// Handy variables.
max_x = n_cols * key_size;
max_y = n_rows * key_size;

// USB settings.
usb_size      = [20.7, 10.2];
usb_offset    = [-4, max_y];

translate([-15,-15]) reference_square();

bottom_plate();
translate([0,100]) switch_plate();
translate([0,200]) support_plate();

translate([0,-100]) difference() {
  bottom_plate();
  translate(usb_offset) translate([usb_size[1],0])
    mirror([0,1,0]) rotate([0,0,90]) usb();
}

module bottom_plate() {
  difference() {
    base_plate();
    translate(usb_offset) translate([usb_size[1],0])
      mirror([0,1,0]) rotate([0,0,90]) usb_screws();
  }
}

module switch_plate() {
  difference() {
    base_plate();
    keys() switch();
  }
}

module support_plate() {
  difference() {
    base_plate();
    keys() square(15, center=true);
  }
}

module base_plate() {
  offset = bezel * sqrt(2) / 2;

  difference() {
    hull() {
      for(x=[-offset,max_x+offset])
        for(y=[-offset,max_y+offset])
          translate([x,y]) circle(d=bezel, center=true);
    }
    screws() screw();
  }
}

module screws() {
  translate([max_x/2,max_y/2]) children();
  for(x=[key_size,key_size*(n_cols-1)])
    for(y=[key_size,key_size*(n_rows-1)])
      translate([x,y]) children();
}

module keys()
  translate([0.5*key_size,0.5*key_size])
    for(x=[0:n_cols-1]) for(y=[0:n_rows-1])
      translate([x*key_size,y*key_size])
        children();

module switch(kerf=0) {
  // hole_size    = 13.97;
  hole_size    = 14;
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

module usb_screws() {
  screw_d = 3;

  translate([0,usb_size[1]])
    translate([0,-2.5]) {
      translate([usb_size[0]-2.75,0]) circle(d=screw_d, center=true);
      translate([2.75,0]) circle(d=screw_d, center=true);
    }
}

module usb() square(usb_size);
module teensy() square(teensy_size);

module screw() circle(d=screw_d, center=true);

module signature(str="αXL") text(str, font="Athelas:style=Bold");

module reference_square() square(10, center=true);
