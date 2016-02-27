# Module (Preferring composition over inheritence) to provide the core proxy
# facilities to all of our checkout and promotion objects.
module CheckoutProxy
  attr_accessor :checkout

  def initialize(checkout)
    self.checkout = checkout
  end

  def method_missing(*args, &block)
    # NOTE: Deliberately using #public_send to discourage objects over-reaching
    # beyond the published API of those further down the stack.
    checkout.public_send(*args, &block)
  end
end
