require "minitest/autorun"

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "layout"

include Alphadox

class TestLayout < Minitest::Test
  make_my_diffs_pretty!

  def test_layout_starts_at_origin
    layout = Layout.new
    assert_here [0, 0], layout.here
  end

  def test_translate
    layout = Layout.new
      .translate [0, 1]
    assert_here [0, 1], layout.here
  end

  def test_rotate
    layout = Layout.new
    layout = layout.translate [1, 0]
    layout = layout.rotate 90

    assert_here [0, 1], layout.here
  end

  def test_block
    actual = []
    Layout.new do
      actual << here

      translate [0, -1] do
        actual << here

        rotate 90 do
          actual << here
        end
      end
    end

    expected = [ [0, 0], [0, -1], [1, 0] ]
    expected.zip(actual).each do |e, a|
      assert_here e, a
    end
  end

  private

  def assert_here(expected, actual)
    expected.zip(actual).each do |e, a|
      assert_in_delta e, a
    end
  rescue Minitest::Assertion
    raise Minitest::Assertion, diff(expected, actual)
  end
end
