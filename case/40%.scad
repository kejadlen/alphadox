// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Increase the resolution for the small screw holes.
$fn = 50;

// Adjusts friction fit of switch holes.
kerf = 0;

n_cols = 10;
n_rows = 4;

// Distance between keys.
key_size = 19;

// Approximate switch size.
switch_size = 14;

// Bezel size.
bezel = 9;

// Screw radius.
screw_radius = 1.5;

// Size of the hole for USB.
usb_size = 10;

teensy_size   = [30.5, 17.8];
teensy_offset = [0, n_rows*key_size - (key_size-switch_size)/2 + bezel/2];

x_offset = n_cols*key_size + 3*bezel;
y_offset = n_rows*key_size + teensy_size[1] + 3*bezel;

translate([-20,0]) square(10, center=true);

                                 switch_plate();
translate([x_offset,0])          teensy_plate();
translate([0,y_offset])          stop_plate();
translate([x_offset,y_offset])   spacer_plate();
translate([0,2*y_offset])        bottom_plate();
translate([x_offset,2*y_offset]) stop_plate();

translate([0,3*y_offset])        caps();

module caps() {
  difference() {
    bottom_plate();
    keys() square(20, center=true);
    signature();
  }
}

module switch_plate() {
  difference() {
    bottom_plate();
    keys() switch_hole();
    signature();
  }
}

module spacer_plate() {
  difference() {
    bottom_plate();
    hull() {
      keys() square(switch_size, center=true);
      translate(teensy_offset)teensy();
    }
  }
}

module stop_plate() {
  spacer_plate();
  translate(teensy_offset) difference() {
    teensy();
    translate([bezel/2,0]) square([teensy_size[0]-bezel,teensy_size[1]]);
  }
}

module teensy_plate() {
  difference() {
    bottom_plate();
    hull() keys() square(switch_size, center=true);
    translate(teensy_offset) {
      teensy();
      translate([-bezel/2,teensy_size[1]/2]) square([bezel,usb_size], center=true);
    }
  }
}

module bottom_plate() {
  difference() {
    minkowski() {
      hull() {
        keys() cap();
        translate(teensy_offset) teensy();
      }
      circle(bezel, center=true);
    }
  screws() screw();
  }
}

module screws() {
  offset = bezel / (2 * sqrt(2));

  translate([-offset,-offset]) children();
  translate([n_cols*key_size+offset,-offset]) children();
  translate([-offset,teensy_offset[1]+teensy_size[1]+offset]) children();
  translate([n_cols*key_size+offset,n_rows*key_size+offset]) children();
}

module teensy() {
  square(teensy_size);
}

module keys() {
  translate([0.5*key_size,0.5*key_size]) for(x=[0:n_cols-1]) for(y=[0:n_rows-1])
    translate([x*key_size,y*key_size]) children();
}

module screw() {
  circle(screw_radius, center=true);
}

module cap() {
  square(key_size, center=true);
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

module signature() {
  translate([0.5*bezel,n_rows*key_size+bezel]) text("αXL", font="Athelas:style=Bold");
}