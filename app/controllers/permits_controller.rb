class PermitsController < ApplicationController
  before_filter :init
      
  protected

  def get_class
    PermitConfig    
  end  
end