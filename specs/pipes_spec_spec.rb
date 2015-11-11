require 'minitest/autorun'

require_relative '../lib/pipes'

describe 'handle_router function' do
  
  it 'must return nil with nonexistent route' do
    handle_router(with_action: 'GET', and_route: '/abcdefg', and_params: {}).must_equal nil
  end

  it 'must return a sensible output with a working route' do
    handle_router(with_action: 'GET', and_route: '/test_route', and_params: {}).must_equal 'render view!'
  end

end

describe 'get_handle function' do

  it 'must return nil with nonexistent route' do
    get_handle(with_action: 'GET', and_route: '/abcdefg').must_equal nil
  end
  
  it 'must return a sensible output with a working route' do
    expected_output = {
                        pipeline: :TestPipeline,
                        presenter: :TestPresenter,
                        view_engine: :TestView,
                        view_name: :test_view,
                        params: [:name, :other]
                      }
    get_handle(with_action: 'GET', and_route: '/test_route').must_equal expected_output
  end
  
end


describe 'build_ppv function' do

  it 'must return pipline, presenter, and view from a working handle' do
    handle = OpenStruct.new(ROUTES['[GET] /test_route'])
    build_ppv(from_handle: handle).must_equal [TestPipeline, TestPresenter, TestView]
  end

end


describe 'build_params function' do

  it 'must filter out params based on keys' do
    params = { foo: 'wat', name: 'Bob' }
    keys =  [:name]
    build_params(from_params: params, with_keys: keys).must_equal name: 'Bob'
  end

end

# test fakes

ROUTES = {
  '[GET] /test_route' => {
      pipeline: :TestPipeline,
      presenter: :TestPresenter,
      view_engine: :TestView,
      view_name: :test_view,
      params: [:name, :other]
  }
}


class TestPipeline

  def self.execute with_params: nil
    params = with_params

    { output: params }
  end
  
end


class TestPresenter 

  def self.build with_data: nil
    data = with_data

    return data
  end

end


class TestView

  def self.render with_data: nil, named: nil
    data = with_data
    view_name = named

    'render view!' 
  end

end

