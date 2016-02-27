# Core checkout class.
class Checkout
  include CheckoutProxy

  def initialize(promotions)
    self.checkout = CheckoutBackend.new
    promotions.each do |promo|
      self.checkout = promo.new(checkout)
    end
  end

  def total
    checkout.total.round(2)
  end
end
