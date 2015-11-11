require 'minitest/autorun'

require_relative '../pipelines'

describe OtherPipeline do

  it 'must have execute return hi greeting' do
    OtherPipeline.execute().must_equal greeting: 'hi'
  end

end


describe CreateUser do

  it 'must have execute return name as output' do
    CreateUser.execute(with_params: { name: 'bob' }).must_equal output: 'bob'
  end

end


describe DoMagic do

  it 'must have execute return hi greeting and output' do
    DoMagic.execute(with_params: {other: 'weird'}).must_equal output: 'weird', greeting: 'hi'
  end

end

