# Concrete representation of the core pre-discount checkout methods.
class CheckoutBackend
  attr_accessor :items

  def initialize
    self.items = {}
  end

  def scan(product)
    if items[product.code].nil?
      self.items[product.code] = Item.new(product, 1)
    else
      self.items[product.code].increment
    end
  end

  def total
    items.values.map(&:line_price).inject(:+) || 0
  end
end
