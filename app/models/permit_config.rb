class PermitConfig < PermissionHolder
  attr_accessor :name
  
  class << self
    attr_accessor :permits
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
      @permits << PermitConfig.new(k, v)
    end    
  end        
end