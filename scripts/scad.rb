require_relative 'kbl'

class SCAD
  TEMPLATE = DATA.read

  attr_reader :kbl

  def initialize(kbl)
    @kbl = kbl
  end

  def to_s
    keys = kbl.keys.map do |key|
      out = 'children();'
      out = "scale(scale ? [#{key.size}, 1] : [1, 1]) #{out}" unless key.size == 1
      out = "rotate(#{key.rotation}) #{out}" unless key.rotation.zero?
      out = "translate([#{key.x}, #{key.y}]) #{out}" unless key.xy == [0, 0]
      out
    end

    TEMPLATE << <<-TO_S

module keys(scale=false) {
  #{keys.join("\n  ")}
}
    TO_S
  end
end

if __FILE__ == $0
  fourkey = KBL.new
  fourkey.instance_eval(File.read(File.join(__dir__, 'fourkey.kbl')))
  puts SCAD.new(fourkey).to_s
end

__END__
$fn = 50; // Increase circle resolution for small screw holes.

everything();

module everything(switch=false) {
  difference() {
    edge_cuts();
    screws() screw();

    if (!switch)
      keys(scale=true) square(18, center=true);
    else
      keys() switch(notch=true);
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

module screw() {
  circle(d=2.1, center=true);
}
