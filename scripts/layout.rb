require 'matrix'
require 'minitest'

module Alphadox
  class Layout
    Key = Struct.new(*%i[ name xy rotation size ]) do
      def x; xy[0]; end
      def y; xy[1]; end
    end

    include Math

    KEY_SIZE = 19

    attr_reader *%i[ keys transforms ]

    def initialize(&block)
      @keys = []
      @transforms = [Matrix.identity(3)]

      instance_eval(&block) if block
    end

    def key(name, rotation: 0, size: 1)
      keys << Key.new(name, transform([0,0]), rotation, size)
    end

    def rotate(degrees)
      rads = PI * degrees / 180

      transform = Matrix[[cos(rads), -sin(rads), 0],
                         [sin(rads), cos(rads),  0],
                         [0,         0,          1]]
      with_transform(transform) { yield }
    end

    def transform(xy)
      point = Matrix.column_vector(xy + [1])
      transforms.each do |transform|
        point = transform * point
      end
      [point[0,0], point[1,0]]
    end

    def translate(x, y)
      transform = Matrix[[1, 0, x],
                         [0, 1, y],
                         [0, 0, 1]]
      with_transform(transform) { yield }
    end

    def with_transform(transform, &block)
      transforms.unshift(transform)
      instance_eval(&block)
      transforms.shift
    end
  end
end

class TestLayout < Minitest::Test
  include Alphadox

  def test_layout
    layout = Layout.new do
      i = 2

      translate(1, 2) { key 'SW0;0' }
      translate(i, 0) { key 'SW0;1' }

      translate(10, -10) do
        key 'SW1;0'

        rotate(-90) do
          key 'SW3;0'
          translate(0, 1) { key 'SW3;1' }
        end
      end

      rotate(90) do
        translate(1, 0) { key 'SW2;0' }
        translate(0, 1) { key 'SW2;1' }

        translate(10, 0) do
          key 'SW4;0'
          translate(-11, 0) { key 'SW4;1' }
        end
      end
    end

    keys = Hash[layout.keys.map {|key| [key.name, key] }]

    assert_xy keys, 'SW0;0', [1, 2]
    assert_xy keys, 'SW0;1', [2, 0]
    assert_xy keys, 'SW1;0', [10, -10]
    assert_xy keys, 'SW2;0', [0, 1]
    assert_xy keys, 'SW2;1', [-1, 0]
    assert_xy keys, 'SW3;0', [10, -10]
    assert_xy keys, 'SW3;1', [11, -10]
    assert_xy keys, 'SW4;0', [0, 10]
    assert_xy keys, 'SW4;1', [0, -1]
  end

  def assert_xy(keys, name, xy)
    x, y = xy
    assert_in_delta x, keys[name].x
    assert_in_delta y, keys[name].y
  end
end

if __FILE__ == $0
  Minitest.autorun
end
