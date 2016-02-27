require "spec_helper"

# Following http://betterspecs.org
describe Checkout do

  describe "#total" do
    let(:promotions) { [Bxgyf, CheckoutPromotionTravelHolder, CheckoutPromotion10PercentOffOver60Gbp] }
    let(:checkout) { Checkout.new(promotions) }
    subject { checkout.total }

    context "Empty Basket" do
      it "is £0" do
        should == 0
      end
    end

    context "Basket 003,003" do
      before do
        checkout.scan(build(:product_003))
        checkout.scan(build(:product_003))
      end

      it "is £39.90" do
        should == BigDecimal("39.90")
      end
    end

    context "Basket 003,003,003" do
      before do
        checkout.scan(build(:product_003))
        checkout.scan(build(:product_003))
        checkout.scan(build(:product_003))
      end

      it "is £39.90" do
        should == BigDecimal("39.90")
      end
    end

    context "Basket 001,002,003" do
      before do
        checkout.scan(build(:product_001))
        checkout.scan(build(:product_002))
        checkout.scan(build(:product_003))
      end

      it "is £66.78" do
        should == BigDecimal("66.78")
      end
    end

    context "Basket 001,003,001" do
      before do
        checkout.scan(build(:product_001))
        checkout.scan(build(:product_003))
        checkout.scan(build(:product_001))
      end

      it "is £36.95" do
        should == BigDecimal("36.95")
      end
    end

    context "Basket 001,002,001,003" do
      before do
        checkout.scan(build(:product_001))
        checkout.scan(build(:product_002))
        checkout.scan(build(:product_001))
        checkout.scan(build(:product_003))
      end

      it "is £73.76" do
        should == BigDecimal("73.76")
      end
    end

    context "Basket 002,002,002,003,003,003" do
      before do
        checkout.scan(build(:product_002))
        checkout.scan(build(:product_002))
        checkout.scan(build(:product_002))

        checkout.scan(build(:product_003))
        checkout.scan(build(:product_003))
        checkout.scan(build(:product_003))
      end

      it "is £129.90" do
        # 1 free cufflink and 1 free tshirt (129.90)
        # + 10% off over 60.
        should == BigDecimal("116.91")
      end
    end
  end

end
