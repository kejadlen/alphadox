module switch_hole(position, notches=use_notched_holes, kerf=0) {
  /* Cherry MX switch hole with the center at `position`. Sizes come
     from the ErgoDox design. */
  hole_size    = 13.97;
  notch_width  = 3.5001;
  notch_offset = 4.2545;
  notch_depth  = 0.8128;
  translate(position) {
    union() {
      square([hole_size-kerf, hole_size-kerf], center=true);
      if (notches == true) {
        translate([0, notch_offset]) {
          square([hole_size+2*notch_depth, notch_width], center=true);
        }
        translate([0, -notch_offset]) {
          square([hole_size+2*notch_depth, notch_width], center=true);
        }
      }
    }
  }
};

translate([13,13]) difference() {
  translate([-12,-12]) { square([62,24]); }
  switch_hole([0,0], true, 0.0);
  switch_hole([19,0], true, 0.05);
  switch_hole([38,0], true, 0.1);
}