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
translate([0,100])  square(10, center=true);

                     bottom_plate();
translate([300,0])   spacer_plate();
translate([0,100])   cord_plate();
translate([300,100]) switch_plate();

module bottom_plate() {
  difference() {
    hull() whole() screws() circle(bezel_radius, center=true);
    whole() screws() screw();
  }
}

module spacer_plate() {
  difference() {
    bottom_plate();

    // Cut out the thumb clusters separately from the rest of the keys
    // since otherwise, the hull clips the bottom-middle screw holes.
    hull() whole() translate([2*key_size, -key_size])
      modifiers() square(14, center=true);
    hull() whole() translate([0, -1.5*key_size])
      thumb_cluster() square(14, center=true);
  }
}

module cord_plate() {
  union() {
    // Cut out the hole for the cord.
    difference() {
      spacer_plate();
      hull() whole() cord_screw() circle(bezel_radius, center=true);
    }

    // Replace the rounded corners for the cord hole in the bezel.
    whole() cord_screw() difference() {
      circle(bezel_radius, center=true);
      screw();
    }
  }
}

module switch_plate() {
  difference() {
    bottom_plate();
    whole() keys() switch_hole();
  }
}

module whole() {
  union() {
    children();
    mirror() children();
  }
}

module screws() {
  translate([2*key_size+screw_offset,-key_size-screw_offset]) children();
  translate([7*key_size+screw_offset,-key_size-screw_offset]) children();
  translate([7*key_size+screw_offset,3*key_size+screw_offset]) children();
  cord_screw() children();
}

module cord_screw() {
  translate([cord_width/2+bezel_radius,3*key_size+screw_offset]) children();
}

module caps() {
  translate([key_size, 0]) alphabet() square(18, center=true);
  translate([2*key_size, -key_size]) modifiers() square(18, center=true);
  translate([0, -1.5*key_size]) thumb_cluster() square([18,27.5], center=true);
}

module keys() {
  translate([key_size, 0]) alphabet() children();
  translate([2*key_size, -key_size]) modifiers() children();
  translate([0, -1.5*key_size]) thumb_cluster() children();
}

module alphabet() {
  translate([key_size/2, key_size/2])
    for(x=[0:4])
      for(y=[0:2])
        translate([key_size*x, key_size*y])
          children([0:$children-1]);
}

module modifiers() {
  translate([key_size/2, key_size/2]) {
    for(x=[0:4]) translate([key_size*x, 0]) children([0:$children-1]);
    for(y=[0:3]) translate([key_size*4, key_size*y]) children([0:$children-1]);
  }
}

module thumb_cluster() {
  translate([key_size/2, 1.5*key_size/2])
    for(x=[0:1]) translate([key_size*x, 0])
      children([0:$children-1]);
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