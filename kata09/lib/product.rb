# Basic representation of a product within the system.
class Product
  KEYS = %w(code name price)
  attr_accessor *KEYS

  def initialize(params = {})
    KEYS.each do |key|
      self.public_send("#{key}=", params[key] || params[key.to_sym])
    end
  end
end
