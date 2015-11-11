require 'sinatra'
require 'sinatra/reloader' if development?

def wrap_sinatra with_action: nil, and_route: nil, and_params: nil
  action, route, params = with_action, and_route, and_params

  output = handle_router with_action: action, and_route: route, and_params: params

  if !output.nil?
    output
  else
    "Nopers, I can't find it."
  end
end

class Foo < Sinatra::Base


  # using sinatra to quick and dirty prove the web side...
  get '/*' do
    route = '/' + params[:splat].first   # eg "some/path/here"

    wrap_sinatra with_action: 'GET', and_route: route, and_params: params
  end

  post '/*' do
    route = '/' + params[:splat].first   # eg "some/path/here"

    wrap_sinatra with_action: 'POST', and_route: route, and_params: params
  end
end
