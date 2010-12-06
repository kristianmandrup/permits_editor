class ApplicationController < ActionController::Base
  protect_from_forgery

  def create      
    if @name != session['name']
      session['name'] = @name
      render :index
      return
    end
        
    if params['object']
      if params['permits'][@name]
        @object.can = PermissionSet.new 
        @object.cannot = PermissionSet.new 
        @object.can.from_params params['permits'][@name]['can'] || {}
        @object.cannot.from_params params['permits'][@name]['cannot'] || {}
      end
    end
    
    @object.save_to_yaml
    render :index    
  end
  
  def init
    get_class.load_from_yaml    
    
    @type = 'permits'    
    @models = [Article, Post]    
    
    @object = if params['object']
      @name = params['object']['name']
      get_class.find(@name).first 
    else
      get_class.first
    end
    
    @objects = get_class.all
    @name = @object.name 
  end  
end