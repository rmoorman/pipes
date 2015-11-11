require 'slim'
require 'tilt'

class GenericView
  def self.render with_data: nil, named: nil
    data = with_data

    #view_name = named
    #@view ||= {}

    #@view[view_name] ||= Tilt.new("views/#{view_name}.slim")
    

    #@view[view_name].render(OpenStruct.new(data))
    "hi"
  end
end


