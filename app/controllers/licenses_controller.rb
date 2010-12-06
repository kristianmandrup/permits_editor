class LicensesController < ApplicationController
  before_filter :init
      
  protected

  def get_class
    LicenseConfig    
  end
end