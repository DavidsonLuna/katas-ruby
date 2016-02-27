require "spec_helper"

# Following http://betterspecs.org
describe CheckoutPromotionTravelHolder do
  let(:backend) { CheckoutBackend.new }
  let(:instance) { described_class.new(backend) }
  subject { instance.total }

  context "when item 001 not in cart" do
    it "does not modify total" do
      should == 0
    end
  end

  context "when item 001 in cart" do
    context "with quantity 1" do
      before do
        instance.scan(build(:product_001))
        expect(backend).to receive(:total).and_return(BigDecimal("123.45"))
      end

      it "does not modify total" do
        should == BigDecimal("123.45")
      end
    end

    context "with quantity 2" do
      before do
        instance.scan(build(:product_001))
        instance.scan(build(:product_001))
      end

      it "should discount total" do
        should == BigDecimal.new("17")
      end
    end
  end
end
