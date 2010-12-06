class UserPermitsController < ApplicationController
  before_filter :init
      
  protected

  def get_class
    UserPermitConfig    
  end
end