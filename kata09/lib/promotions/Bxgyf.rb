class Bxgyf
  include CheckoutProxy

# examine items, find number of items for which discount is applicable.
# if < 3 return 0
#

# 45,45,23,23,19,19
# 45,45,23 => 23
# 23,19,19 => 19


  def total
    checkout.total - promotion_discount
  end

  private

    def prices
      items.map{|id, item| discounted_ids.include?(id) ? [item.price] * item.quantity : nil }.flatten.compact.sort.reverse
    end

    def discounted_ids
      %w(002 003)
    end

    def promotion_discount
      t = 0
      prices.each_slice(3) {|s| s.size == 3 ? t += s.min : 0 }
      t
    end

end
