class ThreeForTwoKidsTshirts
  include CheckoutProxy

# check contains item
# quantity 3 exists within total quantity
# subtract price * that number from total

  def total
    checkout.total - promotion_discount
  end

  private
    def item_price
      items["003"].nil? ? 0 : items["003"].price
    end

    def quantity
      items["003"].nil? ? 0 : items["003"].quantity.to_i
    end

    def promotion_discount
      (quantity / 3) * item_price
    end

end
