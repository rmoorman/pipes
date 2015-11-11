require 'minitest/autorun'

require_relative '../views'

describe GenericView do 

  it 'should render the right string ' do
    GenericView.render(with_data: {output: 'bob'}, named: :create_user).must_equal 'hi bob'
  end

end
