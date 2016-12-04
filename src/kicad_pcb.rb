require 'erb'

require_relative 'layout'
require_relative 'sexp'

module Alphadox
  class KiCadPCB
    BASE_TEMPLATE = File.read(File.expand_path('../templates/kicad_pcb.erb', __FILE__))

    attr_reader *%i[ netlist layout ]

    def initialize(layout, netlist)
      @layout, @netlist = layout, netlist
    end

    def modules
      []
    end

    def nets
      netlist.args.find {|i| i.op == 'nets' }.args.map do |net|
        { code: net.args.find {|i| i.op == 'code' }.args[0],
          name: net.args.find {|i| i.op == 'name' }.args[0] }
      end
    end

    def to_s
      ERB.new(BASE_TEMPLATE, nil, '<>').result(binding)
    end
  end
end

if __FILE__ == $0
  if ARGV.size != 2
    puts "USAGE: #{__FILE__} <layout> <netlist>"
    exit
  end

  include Alphadox

  layout = Layout.new
  layout.instance_eval(File.read(ARGV.shift))

  netlist = SExp.parse(File.read(ARGV.shift))

  puts KiCadPCB.new(layout, netlist).to_s
end

__END__
NETS

  (net 0 "")
  (net 1 /ROW0)
  (net 2 "Net-(SW0:2-Pad2)")
  (net 3 /COL1)
  (net 4 "Net-(SW0:3-Pad2)")
  (net 5 /COL0)
  (net 6 /ROW1)
  (net 7 "Net-(SW1:2-Pad2)")
  (net 8 "Net-(SW1:3-Pad2)")

  (net_class Default "This is the default net class."
    (clearance 0.254)
    (trace_width 0.254)
    (via_dia 0.889)
    (via_drill 0.635)
    (uvia_dia 0.508)
    (uvia_drill 0.127)
    (add_net /COL0)
    (add_net /COL1)
    (add_net /ROW0)
    (add_net /ROW1)
    (add_net "Net-(SW0:2-Pad2)")
    (add_net "Net-(SW0:3-Pad2)")
    (add_net "Net-(SW1:2-Pad2)")
    (add_net "Net-(SW1:3-Pad2)")
  )

MODULES

  (module footprints:MX_FLIP_DIODE (layer F.Cu) (tedit 550DD7AD) (tstamp 551352AA)
    (at 158.178501 89.344501)
    (path /551350A1)
    (fp_text reference SW0:2 (at 0 3.302) (layer F.SilkS)
      (effects (font (size 1.524 1.778) (thickness 0.254)))
    )
    (fp_text value SW0:1 (at 0 3.302) (layer B.SilkS)
      (effects (font (size 1.524 1.778) (thickness 0.254)) (justify mirror))
    )
    (fp_line (start -6.35 -6.35) (end 6.35 -6.35) (layer Dwgs.User) (width 0.381))
    (fp_line (start 6.35 -6.35) (end 6.35 6.35) (layer Dwgs.User) (width 0.381))
    (fp_line (start 6.35 6.35) (end -6.35 6.35) (layer Dwgs.User) (width 0.381))
    (fp_line (start -6.35 6.35) (end -6.35 -6.35) (layer Dwgs.User) (width 0.381))
    (fp_line (start 0 0) (end 0 0) (layer Dwgs.User) (width 0.0254))
    (fp_line (start -6.35 -6.35) (end 6.35 -6.35) (layer Cmts.User) (width 0.381))
    (fp_line (start 6.35 -6.35) (end 6.35 6.35) (layer Cmts.User) (width 0.381))
    (fp_line (start 6.35 6.35) (end -6.35 6.35) (layer Cmts.User) (width 0.381))
    (fp_line (start -6.35 6.35) (end -6.35 -6.35) (layer Cmts.User) (width 0.381))
    (fp_line (start -6.35 -6.35) (end -4.572 -6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start 4.572 -6.35) (end 6.35 -6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start 6.35 -6.35) (end 6.35 -4.572) (layer F.SilkS) (width 0.381))
    (fp_line (start 6.35 4.572) (end 6.35 6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start 6.35 6.35) (end 4.572 6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start -4.572 6.35) (end -6.35 6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start -6.35 6.35) (end -6.35 4.572) (layer F.SilkS) (width 0.381))
    (fp_line (start -6.35 -4.572) (end -6.35 -6.35) (layer F.SilkS) (width 0.381))
    (fp_line (start -6.35 -6.35) (end -4.572 -6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start 4.572 -6.35) (end 6.35 -6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start 6.35 -6.35) (end 6.35 -4.572) (layer B.SilkS) (width 0.381))
    (fp_line (start 6.35 4.572) (end 6.35 6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start 6.35 6.35) (end 4.572 6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start -4.572 6.35) (end -6.35 6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start -6.35 6.35) (end -6.35 4.572) (layer B.SilkS) (width 0.381))
    (fp_line (start -6.35 -4.572) (end -6.35 -6.35) (layer B.SilkS) (width 0.381))
    (fp_line (start -3.81 7.62) (end -1.6637 7.62) (layer B.Cu) (width 0.6096))
    (fp_line (start 1.6637 7.62) (end 3.81 7.62) (layer B.Cu) (width 0.6096))
    (fp_line (start -3.81 7.62) (end -1.6637 7.62) (layer F.Cu) (width 0.6096))
    (fp_line (start 1.6637 7.62) (end 3.81 7.62) (layer F.Cu) (width 0.6096))
    (pad 1 thru_hole circle (at 2.54 -5.08) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask)
      (net 1 /ROW0))
    (pad 2 thru_hole circle (at -3.81 -2.54) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask)
      (net 2 "Net-(SW0:2-Pad2)"))
    (pad "" np_thru_hole circle (at 0 0) (size 3.9878 3.9878) (drill 3.9878) (layers *.Cu)
      (solder_mask_margin -0.254) (zone_connect 2))
    (pad "" np_thru_hole circle (at -5.08 0) (size 1.7018 1.7018) (drill 1.7018) (layers *.Cu *.Mask F.SilkS)
      (solder_mask_margin -0.254) (zone_connect 2))
    (pad "" np_thru_hole circle (at 5.08 0) (size 1.7018 1.7018) (drill 1.7018) (layers *.Cu *.Mask F.SilkS)
      (solder_mask_margin -0.254) (zone_connect 2))
    (pad 1 thru_hole circle (at 3.81 -2.54) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask)
      (net 1 /ROW0))
    (pad 2 thru_hole circle (at -2.54 -5.08) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask)
      (net 2 "Net-(SW0:2-Pad2)"))
    (pad 3 thru_hole circle (at -3.81 5.08) (size 1.651 1.651) (drill 0.9906) (layers *.Cu *.SilkS *.Mask)
      (net 2 "Net-(SW0:2-Pad2)"))
    (pad 4 thru_hole rect (at 3.81 5.08) (size 1.651 1.651) (drill 0.9906) (layers *.Cu *.SilkS *.Mask)
      (net 3 /COL1))
    (pad 3 thru_hole circle (at -3.81 7.62) (size 1.651 1.651) (drill 0.9906) (layers *.Cu *.SilkS *.Mask)
      (net 2 "Net-(SW0:2-Pad2)"))
    (pad 4 thru_hole rect (at 3.81 7.62) (size 1.651 1.651) (drill 0.9906) (layers *.Cu *.SilkS *.Mask)
      (net 3 /COL1))
    (pad 99 smd rect (at -1.6637 7.62) (size 0.8382 0.8382) (layers F.Cu F.Paste F.Mask))
    (pad 99 smd rect (at -1.6637 7.62) (size 0.8382 0.8382) (layers B.Cu B.Paste B.Mask))
    (pad 99 smd rect (at 1.6637 7.62) (size 0.8382 0.8382) (layers F.Cu F.Paste F.Mask))
    (pad 99 smd rect (at 1.6637 7.62) (size 0.8382 0.8382) (layers B.Cu B.Paste B.Mask))
  )

