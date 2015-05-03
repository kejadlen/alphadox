require 'erb'

require_relative 'layout'

module Alphadox
  class SCAD
    TEMPLATE = DATA.read

    attr_reader :layout

    def initialize(layout)
      @layout = layout
    end

    def edge_cuts
      layout.edge_cuts.map {|x,y| "[#{x.round(2)}, #{y.round(2)}]" }
    end

    def keys
      layout.keys.map do |key|
        out = %w[ children(); ]
        out << "scale(scale ? [#{key.size}, 1] : [1, 1])" unless key.size == 1
        out << "rotate(#{key.rotation})" unless key.rotation.zero?
        out << "translate([#{key.x.round(2)}, #{key.y.round(2)}])" unless key.xy == [0, 0]
        out.reverse.join(' ')
      end
    end

    def screws
      layout.screws.map do |x, y|
        out = %w[ children(); ]
        out << "translate([#{x.round(2)}, #{y.round(2)}])" unless [x, y] == [0, 0]
        out.reverse.join(' ')
      end
    end

    def to_s
      ERB.new(TEMPLATE, nil, '<>').result(binding)
    end
  end
end

if __FILE__ == $0
  include Alphadox
  layout = Layout.new
  layout.instance_eval(ARGF.read)
  puts SCAD.new(layout).to_s
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
      keys() switch(notch=false);
  }
}

module keys(scale=false) {
<% keys.each do |key| %>
  <%= key %>
<% end %>
}

module screws() {
<% screws.each do |screw| %>
  <%= screw %>
<% end %>
}

module edge_cuts() {
  polygon([
<% edge_cuts.each do |edge_cut| %>
    <%= edge_cut %>
<% end %>
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
