class HealtController < ApplicationController
  
  def health
    render json: {api: 'OK'}, status: :ok 
  end 

end