# Copyright (c) 2014 Geoff Youngs
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# https://github.com/geoffyoungs/json-minify-rb
#
module JSON
  module Minify
    def self.included(mod)
      mod.send(:extend, self)
    end
    def minify(str)
      ss, buf = StringScanner.new(str), ''

      until ss.eos?
        # Remove whitespace
        if s = ss.scan(/\s+/)

        # Scan punctuation
        elsif s = ss.scan(/[{},:\]\[]/)
          buf << s

        # Scan strings
        elsif s = ss.scan(/""|(".*?[^\\])?"/)
          buf << s

        # Scan reserved words
        elsif s = ss.scan(/(true|false|null)/)
          buf << s

        # Scan numbers
        elsif s = ss.scan(/-?\d+([.]\d+)?([eE][-+]?[0-9]+)?/)
          buf << s

        # Remove C++ style comments
        elsif s = ss.scan(%r<//>)
          ss.scan_until(/(\r?\n|$)/)

        # Remove C style comments
        elsif s = ss.scan(%r'/[*]')
          ss.scan_until(%r'[*]/') or raise SyntaxError, "Unterminated /*...*/ comment - #{ss.rest}"

        # Anything else is invalid JSON
        else
          raise SyntaxError, "Unable to pre-scan string: #{ss.rest}"
        end
      end
      buf
    end

    def minify_parse(buf)
      JSON.parse(minify(buf))
    end
  end
end

module JSON
  include JSON::Minify
end
