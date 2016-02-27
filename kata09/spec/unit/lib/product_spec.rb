require "spec_helper"

# Following http://betterspecs.org
describe Product do

  describe "::KEYS" do
    # To use ::KEYS within the spec, we need a test to assert ::KEYS is valid
    it "contains fields" do
      described_class::KEYS.should == %w(code name price)
    end
  end

  describe "#initialize" do
    let(:instance) { described_class.new(input) }

    context "with keys" do
      let(:input) { {code: "001", name: "Travel Card Holder", price: BigDecimal("4.99")} }

      it "assigns #code" do
        instance.code.should == "001"
      end

      it "assigns #name" do
        instance.name.should == "Travel Card Holder"
      end

      it "assigns #price" do
        instance.price.should == 4.99
      end
    end

    context "without keys" do
      let(:input) { Hash.new }

      # meta.
      described_class::KEYS.each do |key|
        describe "##{key}" do
          subject { instance.public_send(key) }

          it "defaults to nil" do
            should == nil
          end
        end
      end
    end
  end

end

