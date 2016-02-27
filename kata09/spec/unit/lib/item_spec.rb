require "spec_helper"

# Following http://betterspecs.org
describe Item do
  let(:instance) { Item.new(product, quantity) }
  let(:quantity) { 1 }
  let(:product) { build(:product) }

  describe "#initialize" do
    describe "#product" do
      subject { instance.product }

      it "is initialized product" do
        should == product
      end
    end

    describe "#quantity" do
      subject { instance.quantity }

      it "is initialized quantity" do
        should == quantity
      end
    end
  end

  describe "#increment" do
    let(:quantity) { 5 }
    subject { instance.quantity }

    before do
      instance.increment
    end

    it "increases quantity by 1" do
      should == 6
    end
  end

  describe "#price" do
    let(:product) { build(:product, price: 4.29) }
    subject { instance.price }

    it "delegates to product" do
      should == 4.29
    end
  end

  describe "#line_price" do
    let(:product) { build(:product, price: 4.29) }
    let(:quantity) { 2 }
    subject { instance.line_price }

    it "is price multiplied by quantity" do
      should == 8.58
    end
  end

end
