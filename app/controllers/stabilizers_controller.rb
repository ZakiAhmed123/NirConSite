class StabilizersController < ApplicationController

  def view
    @stabilizers = fetch_stabilizers
    @stabilizer = @stabilizers.find {|a| a.id == params[:id]}
  end


end
