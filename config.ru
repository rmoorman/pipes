require 'ostruct'

require_relative 'lib/pipes'

require_relative 'pipelines'
require_relative 'presenters'
require_relative 'views'
require_relative 'routes'


### run program

#handle_router with_action: 'GET', and_route: '/make_something'
#handle_router with_action: 'GET', and_route: '/make_something_else'
#

# right now this program runs as a sinatra web app defined in lib/sinatra_pipes.rb 

#require 'sinatra' #this has to be there or sinatra won't run

#class Foo < Sinatra::Base

#require_relative 'lib/sinatra_pipes'

#end

#run Foo.new



require_relative 'lib/rack_pipes'

run HelloWorld.new
