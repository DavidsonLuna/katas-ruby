require "spec_helper"

# Following http://betterspecs.org
describe CheckoutPromotion10PercentOffOver60Gbp do
  let(:backend) { CheckoutBackend.new }
  let(:instance) { described_class.new(backend) }
  subject { instance.total }
  before do
    expect(backend).to receive(:total).at_least(:once).and_return(total)
  end

  context "when backend total < 60" do
    let(:total) { BigDecimal("59.99") }

    it "does not modify total" do
      should == total
    end
  end

  context "when backend total is 60" do
    let(:total) { BigDecimal("60") }

    it "does not modify total" do
      should == total
    end
  end

  context "when backend total > 60" do
    let(:total) { BigDecimal("60.01") }

    it "discounts total by 10%" do
      subject.should == BigDecimal("54.009")
    end
  end

end
