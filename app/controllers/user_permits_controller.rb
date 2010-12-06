class UserPermitsController < ActionController::Base
  def index
    UserPermitConfig.load_from_yaml    
    @object = if params['permit']
      @name = params['permit']['name']
      UserPermitConfig.find(@name).first 
    else
      UserPermitConfig.first
    end
    
    @name = @object.name
    @type = 'permits'    
    @models = [Article, Post]
  end
  
  def create
    UserPermitConfig.load_from_yaml
    @object = if params['permit']
      @name = params['permit']['name']
      UserPermitConfig.find(@name).first 
    end
    
    return if !@object
    
    if params['permits']
      if params['permits'][@name]
        @object.can = PermissionSet.new 
        @object.cannot = PermissionSet.new 
        @object.can.from_params params['permits'][@name]['can'] || {}
        @object.cannot.from_params params['permits'][@name]['cannot'] || {}
      end
    end
    
    @object.save_to_yaml
    
    redirect_to permits_path    
  end

  def show
    
  end

  def edit
  end  
end