// Adjusts friction fit of switch holes.
kerf = 0;

// Distance between keys.
key_size = 19;

// Distance between keys and screws (orthogonally).
screw_offset = 3;

// Size of the screw hole.
screw_radius = 1.5;

// Radius of the rounded corners on the bezel.
bezel_radius = 6;

// Size of the hole for the USB cord.
cord_width = 10;

// Reference 10mm square for laser cutting.
translate([0,40])   square(10, center=true);

                    bottom_plate();
translate([40,0])   spacer_plate();
translate([0,40])   cord_plate();
translate([40,40])  switch_plate();

module bottom_plate() {
  difference() {
    hull() screws() circle(bezel_radius, center=true);
    screws() screw();
  }
}

module spacer_plate() {
  difference() {
    bottom_plate();
    square(14, center=true);
  }
}

module cord_plate() {
  bezel = screw_offset + 2*bezel_radius;
  difference() {
    bottom_plate();
    translate([0,bezel/2]) square([14,14+bezel], center=true);
  }
}

module switch_plate() {
  difference() {
    bottom_plate();
    switch_hole();
  }
}

module screws() {
  offset = key_size/2+screw_offset;

  for(x=[-offset,offset]) for(y=[-offset,offset]) translate([x,y]) children();
}

module screw() {
  circle(screw_radius, center=true);
}

module switch_hole() {
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