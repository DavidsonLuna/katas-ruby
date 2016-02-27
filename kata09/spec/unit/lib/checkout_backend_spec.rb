require "spec_helper"

# Following http://betterspecs.org
describe CheckoutBackend do
  let(:instance) { CheckoutBackend.new }

  describe "#items" do
    subject { instance.items }

    context "after initialize" do
      it "is empty hash" do
        should == {}
      end
    end
  end

  describe "#scan" do
    subject { instance.items }
    let(:product) { build(:product_001) }

    context "first" do
      before do
        instance.scan(product)
      end

      it "has a key code added to items" do
        subject.keys.should == [product.code]
      end

      it "has an item" do
        subject["001"].should be_an_instance_of(Item)
      end

      it "is linked to the product" do
        subject["001"].product.should == product
      end

      it "has a quantity of 1" do
        subject["001"].quantity.should == 1
      end
    end

    context "second (same product)" do
      before do
        instance.scan(product)
        instance.scan(product)
      end

      it "reuses existing product key" do
        subject.keys.size.should == 1
      end

      it "has a quantity of 2" do
        subject["001"].quantity.should == 2
      end
    end
  end

  describe "#total" do
    subject { instance.total }

    context "when no items" do
      it "is 0" do
        should == 0
      end
    end

    context "when 2 items" do
      let(:product_1) { build(:product, price: 5) }
      let(:product_2) { build(:product, price: 10) }
      before do
        instance.scan(product_1)
        instance.scan(product_2)
        instance.scan(product_2)
      end

      it "is total of product prices" do
        should == 25
      end
    end
  end

end
