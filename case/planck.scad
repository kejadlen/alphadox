// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn          = 50;                  // Increase the resolution for the small screw holes.
key_size     = 19;                  // Distance between keys.
bezel        = 2.5;                 // Bezel size.

// User settings.
n_cols   = 10;  // Number of columns.
n_rows   = 4;  // Number of rows.
screw_d  = 3;  // Screw size.
kerf     = 0;  // Adjusts friction fit of switch holes.

// Handy variables.
max_x = n_cols * key_size;
max_y = n_rows * key_size;

// USB/Teensy settings.
usb_size      = [20.7, 10.2];
usb_offset    = [0, 0];

translate([-15,-15]) reference_square();

everything();

module everything() {
  difference() {
    bottom_plate();
    keys() switch();
  }
}

module bottom_plate() {
  difference() {
    minkowski() {
      hull() keys() square(key_size, center=true);
      bezel();
    }
    screws() screw();
  }
}

module switch_plate() {
  keys() switch();
}

module screws() {
  translate([key_size*n_cols/2,key_size*n_rows/2]) children();
  for(x=[key_size,key_size*(n_cols-1)])
    for(y=[key_size,key_size*(n_rows-1)])
      translate([x,y]) children();
}

module keys()
  translate([0.5*key_size,0.5*key_size])
    for(x=[0:n_cols-1]) for(y=[0:n_rows-1])
      translate([x*key_size,y*key_size])
        children();

module switch() {
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

module usb_screws() {
  translate([0,usb_size[1]])
    translate([0,-2.5]) {
      translate([usb_size[0]-2.75,0]) circle(d=2, center=true);
      translate([2.75,0]) circle(d=2, center=true);
    }
}

module usb() square(usb_size);
module teensy() square(teensy_size);

module bezel() circle(d=bezel, center=true);
module screw() circle(d=screw_d, center=true);

module signature(str="αXL") text(str, font="Athelas:style=Bold");

module reference_square() square(10, center=true);
