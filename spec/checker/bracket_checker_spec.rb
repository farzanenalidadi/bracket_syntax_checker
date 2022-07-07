# frozen_string_literal: true

require 'checker/bracket_checker'

describe BracketChecker do
  describe '#check' do
    let(:valid) { { is_valid: true, char: nil, rule: nil } }
    let(:rule) { { is_valid: false, char: nil, rule: nil } }
    context 'with empty expression' do
      it 'should return is_valid is true' do
        expect(described_class.new('').check).to eq(valid)
      end
    end
    context 'with single expression' do
      context 'with valid expression' do
        it 'should return is_valid is true' do
          expect(described_class.new('[]').check).to eq([valid])
          expect(described_class.new('[<>({}){}[([])<>]]').check).to eq([valid])
          expect(described_class.new('((((((()))))))').check).to eq([valid])
        end
      end
      context 'with invalid expression' do
        it 'should return is_valid is  rule one ' do
          rule[:char] = ']'
          rule[:rule] = 'For each closing bracket there must be an opening of the same type before'
          expect(described_class.new(']()').check).to eq([rule])
        end
        it 'should return is_valid is  rule two ' do
          rule[:char] = ']'
          rule[:rule] =
            'A closing bracket type must match the last opening bracket type that is opened before and has not been closed'
          expect(described_class.new('[(])').check).to eq([rule])
        end

        it 'should return is_valid is  rule three ' do
          rule[:char] = '['
          rule[:rule] = 'For each opening bracket there must be a closing one of the same type'
          expect(described_class.new('[()').check).to eq([rule])
        end
      end
    end

    context 'with multi line expression' do
      context 'with valid expression' do
        it 'should return array of is_valid is true' do
          expect(described_class.new("[]\n([(){}])\n([])").check).to eq([valid, valid, valid])
        end
      end
      context 'with invalid expression' do
        it 'should return array of is_valid is false with rule' do
          expect(described_class.new("]()\n[(])\n[()").check).to eq([
                                                                      { is_valid: false, char: ']',
                                                                        rule: 'For each closing bracket there must be an opening of the same type before' },
                                                                      { is_valid: false, char: ']',
                                                                        rule: 'A closing bracket type must match the last opening bracket type that is opened before and has not been closed' },
                                                                      { is_valid: false, char: '[',
                                                                        rule: 'For each opening bracket there must be a closing one of the same type' }
                                                                    ])
        end
      end
    end
  end
end
