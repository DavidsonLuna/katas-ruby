class CheckoutPromotionTravelHolder
  include CheckoutProxy

  def total
    applicable? ? checkout.total - promotion_discount : checkout.total
  end

  private
    def applicable?
      quantity >= 2
    end

    def promotion_price
      BigDecimal.new("8.5")
    end

    def quantity
      items["001"].nil? ? 0 : items["001"].quantity.to_i
    end

    def promotion_discount
      (quantity * (standard_price - promotion_price))
    end

    def standard_price
      checkout.items["001"].price
    end

end
