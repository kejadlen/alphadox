#!/usr/bin/env ruby

require 'matrix'
require 'minitest'

class TestKBL < Minitest::Test
  def test_kbl
    kbl = KBL.new do
      i = 2

      key 'SW0;0', [1, 2]
      key 'SW0;1', [i, 0]

      translate(10, -10) do
        key 'SW1;0', [0, 0]
      end
    end

    keys = Hash[kbl.keys.map {|key| [key.name, key] }]

    assert_equal 'SW0;0', keys['SW0;0'].name
    assert_equal 1, keys['SW0;0'].x
    assert_equal 2, keys['SW0;0'].y

    assert_equal 2, keys['SW0;1'].x

    assert_equal [10, -10], keys['SW1;0'].xy
  end
end

Key = Struct.new(*%i[ name x y rotation size ]) do
  def xy; [x, y]; end
end

class KBL
  attr_reader *%i[ keys transforms ]

  def initialize(&block)
    @keys = []
    @transforms = [Matrix.identity(3)]

    instance_eval(&block)
  end

  def key(name, xy, rotation: 0, size: 1)
    point = Matrix.column_vector(xy + [1])
    transforms.each do |transform|
      point = transform * point
    end
    keys << Key.new(name, point[0,0], point[1,0], rotation, size)
  end

  def translate(x, y, &block)
    transform = Matrix[[1, 0, x],
                       [0, 1, y],
                       [0, 0, 1]]
    transforms.unshift(transform)
    instance_eval(&block)
    transforms.shift
  end
end

if __FILE__ == $0
  case ARGV.shift
  when 'test'
    Minitest.autorun
  end
end
