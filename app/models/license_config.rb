class LicenseConfig < PermissionHolder
  attr_accessor :name  
  
  class << self
    attr_accessor :licenses  
  end
  
  def self.all
    licenses
  end
  
  def self.first
    licenses.first    
  end 
  
  def self.load_from_yaml
    yaml_content = load_yaml(file_name)
    @licenses = []
    yaml_content.each do |k, v|
      @licenses << LicenseConfig.new(k, v)
    end    
  end    
  
end