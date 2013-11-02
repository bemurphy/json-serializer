require 'json'

class JsonSerializer
  def self.attribute name
    attributes << name if !attributes.include? name
  end

  def self.attributes
    @attributes ||= []
  end

  def self.root key
    @root = key
  end

  def self.root_key
    @root
  end

  attr :object

  def initialize object
    @object = object
  end

  def to_json
    if root = self.class.root_key
      { root => serializable_object }.to_json
    else
      serializable_object.to_json
    end
  end

  protected

  def serializable_object
    serializable_data
  end

  def serializable_data
    self.class.attributes.each_with_object({}) do |name, hash|
      hash[name] = if self.class.method_defined? name
        send name
      else
        object.send name
      end
    end
  end
end

class ArrayJsonSerializer < JsonSerializer
  def initialize object, serializer
    @serializer = serializer
    super object
  end

  protected

  def serializable_object
    object.to_ary.map do |item|
      @serializer.new(item).serializable_data
    end
  end
end
