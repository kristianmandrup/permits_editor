class LicensesController < ActionController::Base
  def index
    LicenseConfig.load_from_yaml    
    @object = if params['license']
      @name = params['license']['name']
      LicenseConfig.find(@name).first 
    else
      LicenseConfig.first
    end
    
    @name = @object.name
    @type = 'licenses'    
    @models = [Article, Post]
  end
  
  def create
    LicenseConfig.load_from_yaml
    @object = if params['license']
      @name = params['license']['name']
      LicenseConfig.find(@name).first 
    end
    
    return if !@object
    
    if params['licenses']
      if params['licenses'][@name]
        @object.can = PermissionSet.new 
        @object.cannot = PermissionSet.new 
        @object.can.from_params params['licenses'][@name]['can'] || {}
        @object.cannot.from_params params['licenses'][@name]['cannot'] || {}
      end
    end
    
    @object.save_to_yaml
    
    redirect_to licenses_path    
  end

  def show
    
  end

  def edit
  end  
end