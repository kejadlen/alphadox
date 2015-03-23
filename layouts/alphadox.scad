$fn = 50; // Increase circle resolution for small screw holes.

everything();

module everything(switch=false) {
  difference() {
    edge_cuts();
    screws() screw();

    if (!switch)
      keys(scale=true) square(18, center=true);
    else
      keys() switch(notch=false);
  }
}

module keys(scale=false) {
  children();
  translate([0.0, 19.0]) children();
  translate([0.0, 38.0]) children();
  translate([19.0, 2.5]) children();
  translate([19.0, 21.5]) children();
  translate([19.0, 40.5]) children();
  translate([38.0, 4.0]) children();
  translate([38.0, 23.0]) children();
  translate([38.0, 42.0]) children();
  translate([57.0, 2.5]) children();
  translate([57.0, 21.5]) children();
  translate([57.0, 40.5]) children();
  translate([76.0, -2.0]) children();
  translate([76.0, 17.0]) children();
  translate([76.0, 36.0]) children();
  translate([19.0, -16.5]) children();
  translate([38.0, -15.0]) children();
  translate([57.0, -16.5]) children();
  translate([76.0, -21.0]) children();
  translate([95.0, -21.0]) children();
  translate([99.75, -2.0]) children();
  translate([99.75, 17.0]) children();
  translate([99.75, 36.0]) children();
  translate([-10.0, -30.0]) rotate(115) scale(scale ? [2, 1] : [1, 1]) children();
  translate([-22.04, -4.17]) rotate(25) children();
  translate([-27.22, -38.03]) rotate(115) scale(scale ? [2, 1] : [1, 1]) children();
  translate([-39.26, -12.2]) rotate(25) children();
}

module screws() {
  translate([-24.63, -21.1]) children();
  translate([9.5, 29.75]) children();
  translate([28.5, -6.25]) children();
  translate([85.5, 26.5]) children();
  translate([85.5, -11.5]) children();
}

module edge_cuts() {
  polygon([
    [-36.78, 4.96],
    [-58.53, -5.19],
    [-30.22, -65.91],
    [34.99, -35.5],
    [119.0, -35.5],
    [119.0, 56.5],
    [-36.78, 56.5]
  ]);
}

module switch(notch=true, kerf=0) {
  hole_size    = 13.9;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.8128;

  union() {
    square(hole_size-kerf, center=true);
    if (notch) {
      for (y=[-notch_offset,notch_offset])
        translate([0,y])
          square([hole_size+2*notch_depth, notch_width], center=true);
    }
  }
}

module screw() {
  circle(d=2.1, center=true);
}
