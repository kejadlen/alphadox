// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Adjusts friction fit of switch holes.
kerf = 0;

// Distance between keys.
key_size = 19;

// How much each hand-half is rotated.
rotation = 10;

// Staggering of the columns, inside->out. (The first
// column is the single thumb key on the inside.)
stagger = [0.25*key_size, 1, 3, 5, 4, 2, 0];

// Distance between the halves.
hand_separation = 2;

// Distance between keys and screws (orthogonally).
screw_offset = 3;

// Nudge for the thumb screws so they can be adjusted
// depending on the size of the thumb caps.
//thumb_nudge = [-key_size, -0.5*key_size-screw_offset];
thumb_nudge = [screw_offset, -5-screw_offset];

// Size of the screw hole.
screw_radius = 1.5;

// Radius of the rounded corners on the bezel.
bezel_radius = 6;

// Size of the hole for the USB cord.
cord_width = 10;

// Reference 10mm square for laser cutting.
translate([0,150])  square(10, center=true);

                     bottom_plate();
translate([300,0])   spacer_plate();
translate([0,150])   cord_plate();
translate([300,150]) switch_plate();

// Helpful for visualizing the keycaps.
translate([0,-150]) difference() {
  bottom_plate();
  whole() caps();
//  whole() keys() switch_hole();
//  translate([0,20]) teensy();
}

module bottom_plate() {
  difference() {
    hull() whole() union() {
      screws() circle(bezel_radius, center=true);
      thumb_screw() circle(bezel_radius, center=true);
    }
    whole() screws() screw();
    whole() cord_screw() screw();
    whole() thumb_screw() screw();
  }
}

module spacer_plate() {
  difference() {
    bottom_plate();

    // Cut out the thumb clusters separately from the rest of the keys
    // since otherwise, the hull clips the bottom-middle screw holes.
    // To cut out all the keys instead, use:
    //     hull() whole() keys() square(14, center=true);
    hull() whole() rotate(rotation) translate([2*key_size, -key_size])
      modifiers() square(14, center=true);
    hull() whole() rotate(rotation) translate([0, -1.5*key_size])
      thumb_cluster() square(14, center=true);
  }
}

module cord_plate() {
  y = rz_fun([7*key_size+screw_offset, 3*key_size+screw_offset])[1];

  union() {
    // Cut out the hole for the cord.
    difference() {
      spacer_plate();
      translate([0,y]) square([cord_width+2*bezel_radius, 2*(bezel_radius+1)], center=true);
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
    translate([0.5*hand_separation,0]) children();
    translate([-0.5*hand_separation,0]) mirror() children();
  }
}

module screws() {
  rotate(rotation) {
    translate([7*key_size+screw_offset,-key_size-screw_offset]) children();
    translate([7*key_size+screw_offset,3*key_size+screw_offset]) children();
  }
  cord_screw() children();
}

module cord_screw() {
  x = (cord_width-hand_separation)/2 + bezel_radius;
  y = rz_fun([7*key_size+screw_offset, 3*key_size+screw_offset])[1];
  translate([x,y]) children();
}

module thumb_screw() {
  rotate(rotation)
    translate([2*key_size+thumb_nudge[0], -key_size+thumb_nudge[1]])
      children();
}

module caps() {
  rotate(rotation) {
    translate([key_size, 0]) alphabet() square(18, center=true);
    translate([2*key_size, -key_size]) modifiers() square(18, center=true);
    translate([0, -1.5*key_size]) thumb_cluster() square([18,27.5], center=true);
  }
}

module keys() {
  rotate(rotation) {
    translate([key_size, 0]) alphabet() children();
    translate([2*key_size, -key_size]) modifiers() children();
    translate([0, -1.5*key_size]) thumb_cluster() children();
  }
}

module alphabet() {
  translate([key_size/2, key_size/2])
    for(x=[0:4])
      for(y=[0:2])
        translate([x*key_size, y*key_size+stagger[x+1]])
          children([0:$children-1]);
}

module modifiers() {
  translate([key_size/2, key_size/2]) {
    for(x=[0:4]) translate([x*key_size, stagger[x+2]]) children();
    for(y=[0:3]) translate([4*key_size, y*key_size+stagger[6]]) children();
  }
}

module thumb_cluster() {
  translate([0.5*key_size, 0.75*key_size])
    for(x=[0:1])
      translate([x*key_size, stagger[x]])
        children();
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

function rz_fun(p) = [p[0]*cos(rotation) - p[1]*sin(rotation),
                      p[0]*sin(rotation) + p[1]*cos(rotation)];

module teensy() {
  square([17.78,30.48], center=true);
}