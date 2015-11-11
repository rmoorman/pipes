class CreateUser

  def self.execute with_params: nil
    params = with_params

    { output: params[:name]}
  end

end

class DoMagic

  def self.execute with_params: nil
    params = with_params

    { output: params[:other], greeting: OtherPipeline.execute()[:greeting] }
  end

end

class OtherPipeline

  def self.execute with_params: nil
    { greeting: 'hi' }
  end

end


