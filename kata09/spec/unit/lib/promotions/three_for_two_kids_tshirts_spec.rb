require "spec_helper"

# Following http://betterspecs.org
describe ThreeForTwoKidsTshirts do
  let(:backend) { CheckoutBackend.new }
  let(:instance) { described_class.new(backend) }
  subject { instance.total }

  context "when item 003 not in cart" do
    it "does not modify total" do
      should == 0
    end
  end

  context "when item 003 in cart" do
    context "with quantity 2" do
      before do
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
        expect(backend).to receive(:total).and_return(BigDecimal("39.90"))
      end

      it "does not modify total" do
        should == BigDecimal("39.90")
      end
    end

    context "with quantity 3" do
      before do
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
      end

      it "should discount total" do
        should == BigDecimal.new("39.90")
      end
    end

    context "with quantity 4" do
      before do
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
        instance.scan(build(:product_003))
      end

      it "should discount total" do
        should == BigDecimal.new("59.85")
      end
    end

    context "with quantity 6" do
      before do
        6.times { instance.scan(build(:product_003)) }
      end

      it "should discount total" do
        should == BigDecimal.new("79.8")
      end
    end
  end
end
