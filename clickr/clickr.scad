$fn      = 50; // Increase the resolution for the small screw holes.
key_size = 19; // Distance between keys.

screw_d = 2.1;

everything();

module everything() {
    translate([-35,  40]) switch_plate();
    translate([ 35,  70]) spacer_plate();
    translate([-35, -40]) spacer_plate();
    translate([ 35, -40]) bottom_plate();
}

module switch_plate() {
    difference() {
        plate();
        switches();
        jst_passthrough();
    }
}

module spacer_plate() {
    difference() {
        plate(feather=true);
        pcb(feather=true);
        jst_passthrough();
    }
}

module bottom_plate() {
    difference() {
        plate(feather=true);
        translate([0, 7.5]) square([30, 37], center=true);
    }
}

module plate(feather=false) {
    difference() {
        hull() screws(feather) circle(d=5, center=true);
        screws(feather) screw();
    }
}

module jst_passthrough() {
    translate([0.4445-in2mm(1.65)/2, 0]) {
        hull() {
            translate([0,  2.5]) circle(d=5, center=true);
            translate([0, -2.5]) circle(d=5, center=true);
        }
        translate([0, 5 - (key_size/2 - 13.9/2)])
            square([5, key_size/2 - 13.9/2]);
    }
}

module screws(feather=false) {
    translate([0, -30.6705]) {
        for(x=[-1, 1]) {
            for(y=[2.5, 62.5]) {
                translate([25*x, y]) children();
            }
            if (feather) {
                translate([25*x, -27.5]) children();
            }
        }
    }
}

module pcb(feather=false) { 
    translate([0.4445, -1.4605]) {
        translate([-in2mm(1.65)/2, -in2mm(2.3)/2]) {
            square([in2mm(1.65), in2mm(2.3)]); 
            if(feather) {
                translate([0, -in2mm(0.9)]) {
                    square([in2mm(1.65), in2mm(0.9)]);
                }
            }
        }
    }
}

module switches() {
    translate([-key_size/2, key_size/2]) switch();
    translate([ key_size/2,   key_size]) switch();
    translate([ key_size/2,          0]) switch();
    translate([ key_size/2,  -key_size]) switch();
    translate([-key_size/2,  -key_size]) switch();
}

module feather() {
    difference() {
        square([in2mm(2), in2mm(0.9)], center=true);
        for(x=[1,-1])
            for(y=[1,-1])
                translate([in2mm(1.8/2)*x, in2mm(0.7/2)*y])
                    circle(d=in2mm(0.1), center=true);
    }
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

function in2mm(in) = 25.4*in;

module screw() circle(d=screw_d, center=true);

module reference_square() square(10, center=true);