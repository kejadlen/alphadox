require "matrix"

module Alphadox
  include Math

  class Layout
    attr_reader :here

    def initialize(transform=Matrix.unit(3), &block)
      @transform = transform

      instance_eval(&block) if block
    end

    def here
      matrix = @transform * Matrix.column_vector([0, 0, 1])
      matrix.column(0).to_a[0, 2]
    end

    def translate(xy, &block)
      dx, dy = *xy
      transform = Matrix[[1, 0, dx],
                         [0, 1, dy],
                         [0, 0, 1]]

      with_transform(transform, &block)
    end

    def rotate(deg, &block)
      rads = PI * deg / 180
      transform = Matrix[[cos(rads), -sin(rads), 0],
                         [sin(rads), cos(rads),  0],
                         [0,         0,          1]]

      with_transform(transform, &block)
    end

    private

    def with_transform(t, &block)
      Layout.new(t * @transform, &block)
    end
  end
end
