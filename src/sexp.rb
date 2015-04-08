require "minitest/autorun"

require "strscan"

module Alphadox
  module SExp
    # A quick and dirty s-expression parser to read in KiCAD files.
    def self.parse(str)
      ss = StringScanner.new(str)
      raise "OMG" if ss.scan(/\s*\(/).nil?

      stack = [[]]

      until ss.eos?
        case
        when ss.scan(/\(/)
          stack << []
        when ss.scan(/\)/)
          last = stack.pop
          return last if stack.empty?
          stack.last << last
        when text = ss.scan(/".*[^\\]"/)
          stack.last << text.gsub(/\A"(.*)"\z/, '\1').gsub('\"', '"')
        when text = ss.scan(/[^)\s]+/)
          stack.last << text
        when ss.scan(/\s+/)
          # Ignore whitespace
        else
          raise "OMG"
        end
      end

      raise "OMG"
    end
  end

  class TestSExp < Minitest::Test
    def assert_parsed(expected, input)
      assert_equal expected, SExp.parse(input)
    end

    def test_sexp
      assert_parsed [], "()"
      assert_parsed %w[ abc ], "(abc)"
      assert_parsed %w[ abc ], "(abc)(def)"
      assert_parsed %w[ abc def ], "(abc def)"
      assert_parsed [ "abc", %w[ def ] ], "(abc (def))"
      assert_parsed [ %w[ abc ], %w[ def ] ], "((abc) (def))"
      assert_parsed [ "abc def" ], '("abc def")'
      assert_parsed [ 'abc"def' ], '("abc\"def")'

      assert_raises(RuntimeError) { SExp.parse("(abc") }
      assert_raises(RuntimeError) { SExp.parse("a") }
    end
  end
end
