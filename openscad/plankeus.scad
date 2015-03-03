// Inspired by @technomancy's Atreus project:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn          = 50;                  // Increase the resolution for the small screw holes.
key_size     = 19;                  // Distance between keys.
bezel        = 5;                   // Bezel size.

// User settings.
n_cols   = 5;  // Number of columns (not including the thumb cluster).
n_rows   = 4;  // Number of rows.
rotation = 10; // How much each hand-half is rotated.
hand_sep = 2;  // Distance between the halves.
screw_d  = 2.1;  // Screw size.

// Staggering of the columns, inside->out. (The first
// column is the single thumb key on the inside.)
stagger = [0.25*key_size, 0, 5, 11, 6, 0, -3];

// Handy variables for future calculations.
max_y         = (n_rows-1)*key_size+stagger[n_cols];
max_x         = (n_cols+1)*key_size;
top_right_rot = rz_fun([max_x, max_y]);

// USB/Teensy settings.
usb_size    = [20.7, 10.2];
teensy_size = [18.0, 30.5];
usb_offset  = [-usb_size[0]/2,top_right_rot[1]-usb_size[1]+bezel/2];

//translate([-50,0]) reference_square();

// For reference!
//translate([0, -90]) everything();

translate([0,30])  bottom_plate();
translate([0,140]) switch_plate();

//translate() {
//  difference() {
//    hull() minkowski() {
//      kerf_test();
//      circle(r=bezel);
//    }
//    kerf_test();
//    translate([-0.5*key_size,0]) screw();
//  }
//}

module kerf_test() {
  n = 5;
  for(i=[0:n]) translate([i*key_size,0]) switch(kerf=0.05*i);
  for(i=[0:n-1])
    translate([(i+0.5)*key_size,key_size*(i-(n-1)/2)/(1.5*n)])
      circle(d=screw_d-(0.1*i), center=true);
}

module everything() {
  difference() {
    base_plate();
    whole() {
      keys() square(18, center=true);
      thumb_cluster() square([18,27], center=true);
    }
    translate([0,30]) teensy();
    translate([-usb_size[0]/2,80-usb_size[1]]) difference() { usb(); usb_screws(); }
  }
}

module bottom_plate() {
  difference() {
    base_plate();
    translate([3,0]) translate(top_right_rot) rotate(-80) translate([0,-usb_size[1]]) usb_screws();
  }
}

module switch_plate() {
  difference() {
    base_plate();
    whole() {
      keys() switch(notch=true);
    }
  }
}

module base_plate() {
  difference() {
    hull() whole() bezel();
    whole() screws() screw();
  }
}

module bezel() {
  translate([max_x,-1*key_size+stagger[n_cols]]) circle(d=bezel, center=true);
  translate([max_x,(n_rows-1)*key_size+stagger[n_cols]+2]) circle(d=bezel, center=true);
  translate([key_size*2,-1.5*key_size+stagger[1]-1]) circle(d=bezel, center=true);
}

module whole() {
  union() {
    translate([0.5*hand_sep,0]) rotate(rotation) children();
    translate([-0.5*hand_sep,0]) mirror() rotate(rotation) children();
  }
}

module screws() {
  col_1 = 2*key_size;
  col_2 = n_cols*key_size+1;
  translate([col_1+1, -1*key_size+stagger[2]]) children();
  translate([col_1+1,  1*key_size+stagger[2]]) children();
  translate([col_1-1,  3*key_size+stagger[1]]) children();
  translate([col_2,    0*key_size+stagger[n_cols]]) children();
  translate([col_2,    2*key_size+stagger[n_cols]]) children();
}

module keys() {
  translate([key_size, 0]) alphabet() children();
  translate([2*key_size, -key_size]) modifiers() children();
  thumb_cluster() children();
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
  translate([0, -1.5*key_size]) 
  translate([0.5*key_size, 0.75*key_size])
    for(x=[0:1])
      translate([x*key_size, stagger[x]])
        children();
}

module switch(notch=false, kerf=0) {
  hole_size    = 13.9;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.8128;

  union() {
    square(hole_size-kerf, center=true);
    if(notch) {
      for(y=[-notch_offset,notch_offset])
        translate([0,y])
          square([hole_size+2*notch_depth, notch_width], center=true);
    }
  }
}

module usb_screws() {
  translate([0,usb_size[1]])
    translate([0,-2.5]) {
      translate([usb_size[0]-2.75,0]) screw();
      translate([2.75,0]) screw();
    }
}

module usb() square(usb_size);
module teensy() square(teensy_size, center=true);

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
