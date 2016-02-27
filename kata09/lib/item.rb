# Represents an Product in the checkout after it has been scanned by the
# checkout scanner. It's core responsibility is acting as a line item, and
# keeping track of meta data such as quantity etc.
class Item
  attr_accessor :product
  attr_accessor :quantity

  extend Forwardable
  def_delegators :product, :price

  def initialize(product, quantity)
    self.product = product
    self.quantity = quantity
  end

  def increment
    self.quantity += 1
  end

  def line_price
    price * quantity
  end
end
