kerf = 0; // Adjusts friction fit of switch holes

key_spacing = 19;

screw_dist = 3;
washer = 4;
screw = 1.5;

all();
translate([-10,-10]) square(10, center=true);

module all() {
  translate([key_spacing,key_spacing]) {
    translate([0,0])   base_plate();
    translate([40,0])  cord_plate();
    translate([80,0])  spacer_plate();
    translate([120,0]) key_plate();

    translate([0,40]) kerf_test();
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

module base_plate() {
  difference() {
    hull() screw_holes(r=washer);
    screw_holes();
  }
}

module spacer_plate() {
  difference() {
    base_plate();
    hull() square(17, center=true);
  }
}

module cord_plate() {
  hole_size = 12; // Actually 4 since it's rounded off by 8mm of bezel

  union() {
    difference() {
      spacer_plate();
      translate([0,key_spacing/2+screw_dist]) square([hole_size,key_spacing],center=true);
    }
    translate([hole_size/2,key_spacing/2+screw_dist]) screw_hole(washer);
    translate([-hole_size/2,key_spacing/2+screw_dist]) screw_hole(washer);
  }
}

module key_plate() {
  difference() {
    base_plate();
    switch_hole();
  }
}

module screw_holes(r=screw) {
  dist = key_spacing/2 + screw_dist;

  for(i=[dist,-dist])
    for(j=[dist,-dist])
      translate([i,j]) screw_hole(r);
}

module screw_hole(r) {
  circle(r,center=true);
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