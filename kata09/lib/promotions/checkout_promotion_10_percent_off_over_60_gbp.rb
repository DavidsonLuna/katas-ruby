class CheckoutPromotion10PercentOffOver60Gbp
  include CheckoutProxy

  def total
    checkout.total - discount
  end

  private
    def applicable?
      BigDecimal(checkout.total.to_s) > 60
    end

    def discount
      if applicable?
        checkout.total - (checkout.total * BigDecimal("0.9"))
      else
        0
      end
    end

end
