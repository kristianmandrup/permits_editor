class PermissionHolder  
  attr_accessor :can, :cannot

  def initialize name, attributes = {}
    self.name = name
    self.can = PermissionSet.new
    self.cannot = PermissionSet.new
    attributes.each{|key, value| send :"#{key}=", PermissionSet.new(value)}    
  end

  def persisted?
    false
  end

  def can? action, model    
    return nil if !can.respond_to? action
    models = can.send action
    models ? models.include?(model.to_s) : false 
  end    

  def cannot? action, model    
    return nil if !cannot.respond_to? action
    models = cannot.send action
    models ? models.include?(model.to_s) : false 
  end    

  def self.find name
    return nil if !name
    all.select{|a| a.name == name}
  end

  def self.load_yaml file    
    YAML.load_file(file)
  end

  def load_yaml file
    self.class.load_yaml file
  end

  def save_yaml file, &block
    content = yield block
    content.gsub!(/!ruby\/object:PermissionSet/, '')
    puts "save to file: #{file}"
    File.open(file, "w") {|file| file.puts(content) }    
  end

  
  def save_to_yaml
    yaml_content = load_yaml(file_name)
    yaml_content[name]['can'] = can
    yaml_content[name]['cannot'] = cannot
    puts "can: #{can}"
    puts "cannot: #{cannot}"
    puts "save yaml: #{yaml_content}"
    save_yaml(file_name) do 
      yaml_content.to_yaml
    end
  end

  def load_from_yaml
    yaml_content = load_yaml(file_name)    
    self.can = yaml_content[name]['can']
    self.cannot = yaml_content[name]['cannot']
  end
  
  def remove_from_yaml
    yaml_content = load_yaml(file_name)
    yaml_content[name] = ''
    yaml_content.save(file_name)
  end
  
  protected

  def self.file_name
    file = self.to_s.gsub(/Config/, '').to_s.underscore.pluralize + '.yaml' 
    file = File.join('config', file)
  end  
  
  def file_name
    self.class.file_name
  end  
end
