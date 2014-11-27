// Adjusts friction fit of switch holes
kerf = 0;

hand_separation = 0.5;

usb_hole = 14;

washer_radius = 6;
offset = washer_radius / sqrt(2);
screw_radius = 1.5;

key_spacing = 19;

// Used for cutting out the spacer.
key_hole_size = 17;

translate([-10,10]) square(10, center=true); // Reference square for laser cutting

bottom_plate();
translate([0,120]) spacer_plate();
translate([0,240]) switch_plate();

module bottom_plate(switch=true) {
  difference() {
    hull() whole_screws(r=washer_radius);
    whole_screws();
  }
}

module spacer_plate() {
  difference() {
  union() {
  difference() {
    bottom_plate();
    hull() whole_keys(switch=false);
    translate([0,4*key_spacing+offset]) square([usb_hole+2*washer_radius, 2*washer_radius], center=true);
  }
  translate([key_spacing-offset, 4*key_spacing+offset]) screw_hole(washer_radius);
  translate([-key_spacing+offset, 4*key_spacing+offset]) screw_hole(washer_radius);
  }
  translate([key_spacing-offset, 4*key_spacing+offset]) screw_hole();
  translate([-key_spacing+offset, 4*key_spacing+offset]) screw_hole();
  }
}

module switch_plate() {
  difference() {
    bottom_plate();
    whole_keys(false);
  }
}

module whole_screws(r=screw_radius) {
  translate([hand_separation/2, 0]) half_screws(r);
  mirror([1,0,0]) translate([hand_separation/2, 0]) half_screws(r);
}

module whole_keys(switch=true) {
  translate([hand_separation/2, 0]) half_keys(switch);
  mirror([1,0,0]) translate([hand_separation/2, 0]) half_keys(switch);
}

module half_keys(switch=true) {
  translate([key_spacing, key_spacing]) {
    alphabet(switch);
    translate([key_spacing, -key_spacing]) modifiers(switch);
    translate([-key_spacing, -key_spacing*1.5]) thumb_cluster(switch);
  }
}

module half_screws(r=screw_radius) {
  translate([key_spacing, key_spacing]) {
    translate([key_spacing+offset, -1.5*key_spacing-offset]) screw_hole(r);
    translate([6*key_spacing+offset, -key_spacing-offset]) screw_hole(r);
    translate([6*key_spacing+offset, 3*key_spacing+offset]) screw_hole(r);
    translate([-offset, 3*key_spacing+offset]) screw_hole(r);
  }
}

module alphabet(switch=true) {
  translate([key_spacing/2, key_spacing/2])
    for(x=[0:4])
      for(y=[0:2])
        translate([key_spacing*x, key_spacing*y])
          hole(switch);
}

module modifiers(switch=true) {
  translate([key_spacing/2, key_spacing/2]) {
    for(x=[0:4]) translate([key_spacing*x, 0]) hole(switch);
    for(y=[0:3]) translate([key_spacing*4, key_spacing*y]) hole(switch);
  }
}

module thumb_cluster(switch=true) {
  translate([key_spacing/2, key_spacing*3/4])
    for(x=[0:1]) translate([key_spacing*x, 0])
      hole(switch, [1,1.5]);
}

// For visualization (or a top plate)
module hole(switch=true, size=[1,1]) {
  if(switch) {
    switch_hole();
  } else {
    scale(size) square(key_hole_size, center=true);
  }
}

module screw_hole(r=screw_radius) {
  circle(r, center=true);
}

module switch_hole(kerf=kerf) {
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

module kerf_test(start=0, inc=0.05, stop=0.3) {
  times = (stop-start)/inc;

  difference() {
    hull() union() {
      screw_holes([0,0], r=washer);
      translate([key_spacing*(times-1),0]) screw_holes([0,0], r=washer);
    }
    for(i=[0:times]) {
      translate([key_spacing*i,0]) switch_hole(kerf=(i*inc+start));
    }
    translate([-(key_spacing/2 + screw_dist),0]) screw_hole(); // marker dot
  }
}