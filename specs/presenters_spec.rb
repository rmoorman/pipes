require 'minitest/autorun'

require_relative '../presenters'

describe GenericPresenter do

  it 'must have build return the same hash value as input' do
    input = { foo: 'bar' }
    GenericPresenter.build(with_data: input).must_equal input
  end

end

