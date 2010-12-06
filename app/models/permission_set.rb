class PermissionSet
  attr_accessor :read, :write, :update, :manage, :create, :delete, :owns

  def initialize attributes = {}
    attributes.each{|key, value| send :"#{key}=", value}    
  end
  
  def from_params params
    params.each do |key, value|
      send "#{key}=", value.keys
    end    
  end

  def from_yaml yaml
    yaml.each do |key, value|
      puts "set: #{key} = #{value}" 
      # send key, value if value == 
    end
  end  
end