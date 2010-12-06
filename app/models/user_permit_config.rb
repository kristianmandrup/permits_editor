class UserPermitConfig < PermissionHolder
  attr_accessor :name, :email
  
  class << self
    attr_accessor :permits
  end

  def name
    self.email
  end

  def name= value
    self.email = value
  end
  
  def self.all
    permits
  end
  
  def self.first
    permits.first    
  end
  
  def self.load_from_yaml
    yaml_content = load_yaml(file_name)
    @permits = []
    yaml_content.each do |k, v|
      @permits << UserPermitConfig.new(k, v)
    end    
  end        
end