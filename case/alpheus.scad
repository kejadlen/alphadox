// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn          = 20;                  // Increase the resolution for the small screw holes.
key_size     = 19;                  // Distance between keys.
bezel        = 9;                   // Bezel size.
screw_offset = bezel / (2*sqrt(2)); // Screw offset into the bezel.

// User settings.
n_cols   = 6;  // Number of columns (not including the thumb cluster).
n_rows   = 4;  // Number of rows.
rotation = 10; // How much each hand-half is rotated.
hand_sep = 2;  // Distance between the halves.
screw_d  = 3;  // Screw size.
kerf     = 0;  // Adjusts friction fit of switch holes.

// Staggering of the columns, inside->out. (The first
// column is the single thumb key on the inside.)
stagger = [0.25*key_size, 0, 5, 11, 6, 0, -3];

// Handy variables for future calculations.
y_max         = (n_rows-1)*key_size+stagger[n_cols]+screw_offset;
x_max         = (n_cols+1)*key_size+screw_offset;
top_right_rot = rz_fun([x_max, y_max]);

// USB/Teensy settings.
usb_size    = [20.7, 10.2];
teensy_size = [18.0, 30.5];
usb_offset  = [-usb_size[0]/2,top_right_rot[1]-usb_size[1]+bezel/2];

// Nudge for the thumb screws so they can be adjusted
// depending on the size of the thumb caps.
thumb_nudge = [screw_offset, -5-screw_offset];

translate([0,-50]) reference_square();

everything();

module everything() {
  difference() {
    hull() whole() {
      screws() bezel();
    }
    whole() {
      caps();
      // keys() switch_hole();
      screws() screw();
    }
    translate(usb_offset) usb();
    translate([-teensy_size[0]/2,10]) teensy();
  }
  translate(usb_offset) usb_screws();
}

module spacer_plate() {
  difference() {
    bottom_plate();
    hull() {
      whole() keys() square(key_size, center=true);
    }
  }
}

module bottom_plate() {
  difference() {
    hull() whole() {
      screws() bezel();
    }
    whole() {
      screws() screw();
    }
    translate(usb_offset) usb_screws();
  }
}

module whole() {
  union() {
    translate([0.5*hand_sep,0]) children();
    translate([-0.5*hand_sep,0]) mirror() children();
  }
}

module screws() {
  rotate(rotation) {
    translate([x_max,0]) {
      translate([0,-key_size+stagger[n_cols]-screw_offset])
        children();
      translate([0,y_max])
        children();
    }

    // Thumb cluster screws.
    translate([2*key_size,-key_size])
      translate(thumb_nudge)
        children();
  }

  // Screws near the USB connector.
  x = (usb_size[0]-hand_sep)/2 + bezel/2;
  translate([x,top_right_rot[1]]) children();
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
    for(x=[0:(n_cols-1)])
      for(y=[0:(n_rows-2)])
        translate([x*key_size, y*key_size+stagger[x+1]])
          children([0:$children-1]);
}

module modifiers() {
  translate([key_size/2, key_size/2])
    for(x=[0:(n_cols-2)])
      translate([x*key_size, stagger[x+2]])
        children();
}

module thumb_cluster() {
  translate([0.5*key_size, 0.75*key_size])
    for(x=[0:1])
      translate([x*key_size, stagger[x]])
        children();
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

// Useful for visualizing how the keys will look.
module caps() {
  rotate(rotation) {
    translate([key_size, 0]) alphabet() square(18, center=true);
    translate([2*key_size, -key_size]) modifiers() square(18, center=true);
    translate([0, -1.5*key_size]) thumb_cluster() square([18,27.5], center=true);
  }
}

module reference_square() square(10, center=true);

// Computes post-rotation coordinates.
function rz_fun(p) = [p[0]*cos(rotation) - p[1]*sin(rotation),
                      p[0]*sin(rotation) + p[1]*cos(rotation)];

//// Reference 10mm square for laser cutting.
//translate([0,150])  square(10, center=true);
//
//                     difference() { bottom_plate(); signature(); }
//translate([300,0])   spacer_plate();
//translate([0,150])   cord_plate();
//translate([300,150]) switch_plate();
//
//// Helpful for visualizing the keycaps.
//translate([0,-150]) difference() {
//  bottom_plate();
//  whole() caps();
////  whole() keys() switch_hole();
////  translate([0,20]) teensy();
//}
//
//module signature() {
//  offset = rz_fun([7*key_size+screw_offset,3*key_size+screw_offset]);
//  translate([-offset[0],offset[1]])
//    translate([0,-10]) text("αdox", font="Athelas:style=Bold");
//}
//
//module bottom_plate() {
//  difference() {
//    hull() whole() union() {
//      screws() circle(bezel_radius, center=true);
//      thumb_screw() circle(bezel_radius, center=true);
//    }
//    whole() screws() screw();
//    whole() cord_screw() screw();
//    whole() thumb_screw() screw();
//  }
//}
//
//module spacer_plate() {
//  difference() {
//    bottom_plate();
//
//    // Cut out the thumb clusters separately from the rest of the keys
//    // since otherwise, the hull clips the bottom-middle screw holes.
//    // To cut out all the keys instead, use:
//    //     hull() whole() keys() square(14, center=true);
//    hull() whole() rotate(rotation) translate([2*key_size, -key_size])
//      modifiers() square(14, center=true);
//    hull() whole() rotate(rotation) translate([0, -1.5*key_size])
//      thumb_cluster() square(14, center=true);
//  }
//}
//
//module cord_plate() {
//  y = rz_fun([7*key_size+screw_offset, 3*key_size+screw_offset])[1];
//
//  union() {
//    // Cut out the hole for the cord.
//    difference() {
//      spacer_plate();
//      translate([0,y]) square([cord_width+2*bezel_radius, 2*(bezel_radius+1)], center=true);
//    }
//
//    // Replace the rounded corners for the cord hole in the bezel.
//    whole() cord_screw() difference() {
//      circle(bezel_radius, center=true);
//      screw();
//    }
//  }
//}
//
//module switch_plate() {
//  difference() {
//    bottom_plate();
//    whole() keys() switch_hole();
//  }
//}
//
//module cord_screw() {
//  x = (cord_width-hand_separation)/2 + bezel_radius;
//  y = rz_fun([7*key_size+screw_offset, 3*key_size+screw_offset])[1];
//  translate([x,y]) children();
//}
//
//module screw() {
//  circle(screw_radius, center=true);
//}
//
//module teensy() {
//  square([17.78,30.48], center=true);
//}

