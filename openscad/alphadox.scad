// Reference:
//
// https://github.com/technomancy/atreus/blob/master/case/openscad/atreus_case.scad

// Settings that most likely don't need adjusting.
$fn      = 10; // Increase the resolution for the small screw holes.
key_size = 19; // Distance between keys.

// User settings.
n_cols         = 6;
n_rows         = 4;
n_thumbs       = 2;
thumb_offset   = [-10, -40]; // Default Ergodox offset: [-10, -30]
thumb_rotation = 25;
bezel          = 5;

// Staggering of the columns, inside->out.
//
// For reference, the Ergodox stagger:
//   122.24766
//   120.97766
//   119.38
//   120.97766
//   124.15266
//   124.15266
stagger = [0, 2.5, 7.5, -2.5, -17.5, -20];

// For reference!
everything(true);

module everything(switch=false, teensy=false) {
  difference() {
    edge_cuts();

    if (!switch)
      keys(scale=true) square(18, center=true);
    else
      keys() switch(notch=false);

    if (teensy)
      translate([-35, 30]) teensy();
  }
}

module edge_cuts() {
  min_x = (thumb_offset + rz_fun([(0.5-n_thumbs)*key_size - bezel,
                                  2*key_size + bezel],
                                 thumb_rotation))[0];
  max_x = (n_cols)*key_size + bezel;
  min_y = -1.5*key_size + min(stagger) - bezel;
  max_y = (n_rows-1.5)*key_size + max(stagger) + bezel;

  thumb_xy = thumb_offset + rz_fun([(0.5-n_thumbs)*key_size - bezel,
                                    -key_size - bezel],
                                   thumb_rotation);

  polygon([
    thumb_xy,
    [(min_y - thumb_xy[1])/tan(thumb_rotation) + thumb_xy[0], min_y],
    [max_x, min_y],
    [max_x, max_y],
    [min_x, max_y],
    thumb_offset + rz_fun([(0.5-n_thumbs)*key_size - bezel,
                           2*key_size + bezel],
                          thumb_rotation),
  ]);
}

module keys(scale=false) {
  identity   = [1, 1];
  one_five_u = scale ? [1.5, 1] : identity;
  two_u      = scale ? [2, 1] : identity;

  // Alphabet
  for (x=[0:n_cols-2])
    for (y=[0:2])
      translate([x*key_size, y*key_size+stagger[x]])
        children();

  // Bottom row
  for (x=[1:n_cols-1])
    translate([x*key_size, -key_size+stagger[x]])
      children();

  // Far column
  for (y=[0:n_rows-2])
    translate([(n_cols-0.75)*key_size, y*key_size+stagger[n_cols-1]])
      scale(one_five_u)
        children();

  // Thumb cluster
  translate(thumb_offset)
    rotate(thumb_rotation)
      for (i=[0:n_thumbs-1])
        translate([-i*key_size, 0]) {
          rotate(90) // The main thumb switches are mounted sideways
            scale(two_u)
              children();
          translate([0, 1.5*key_size])
            children();
        }
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

teensy_size = [18.0, 30.5];
module teensy() square(teensy_size, center=true);

// Computes post-rotation coordinates.
function rz_fun(p, r) = [p[0]*cos(r) - p[1]*sin(r),
                         p[0]*sin(r) + p[1]*cos(r)];