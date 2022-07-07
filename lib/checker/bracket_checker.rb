# frozen_string_literal: true

class BracketChecker
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def check
    return render_response(true) if expression.empty?

    expression_lines = expression.split("\n")
    checker = []
    expression_lines.each do |line|
      checker << valid_parentheses(line)
    end
    checker
  end

  def valid_parentheses(str)
    pattern = { '(' => ')', '<' => '>', '[' => ']', '{' => '}' }
    stack = []
    if pattern.values.include? str.chars.first
      return  render_response(false, str.chars.first,
                              :match_not_opening_bracket)
    end

    str.chars do |char|
      if pattern.keys.include? char
        stack << pattern[char]
      else
        return render_response(false, char, :match_not_closing_bracket) unless stack.pop == char
      end
    end
    return render_response(false, pattern.key(stack.pop), :different_type_of_bracket) unless stack.empty?

    render_response(true)
  end

  def rules
    {
      match_not_opening_bracket: 'For each closing bracket there must be an opening of the same type before',
      match_not_closing_bracket: 'A closing bracket type must match the last opening bracket type that is opened before and has not been closed',
      different_type_of_bracket: 'For each opening bracket there must be a closing one of the same type'
    }
  end

  def render_response(is_valid, char = nil, rule = nil)
    { is_valid: is_valid, char: char, rule: rules[rule] }
  end
end
