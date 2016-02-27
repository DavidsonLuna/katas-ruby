require "spec_helper"

# Following http://betterspecs.org
describe Checkout do
  let(:instance) { Checkout.new(promotions) }
  let(:promotions) { [] }

  describe "#initialize" do
    context "Without any promotions" do
      it "#checkout points to a CheckoutBackend instance" do
        instance.checkout.should be_an_instance_of(CheckoutBackend)
      end
    end

    context "with a promotion" do
      let(:promotions) { [MockPromotion] }

      it "#checkout points to promotion" do
        instance.checkout.should be_an_instance_of(MockPromotion)
      end

      it "stacks checkout backend after the promotion" do
        instance.checkout.checkout.should be_an_instance_of(CheckoutBackend)
      end
    end
  end

  describe "#total" do
    subject { instance.total }
    before do
      expect(instance).to receive(:checkout).and_return(double("CheckoutBackend", total: BigDecimal("4.19561")))
    end

    it "rounds to 2 decimal places" do
      should == BigDecimal.new("4.2")
    end
  end

end
