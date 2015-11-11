
class GenericPresenter 

  def self.build with_data: nil
    data = with_data

    # in a real presenter, you would transform and translate the data to fit 
    # whatever view you are working with

    return data
  end

end

