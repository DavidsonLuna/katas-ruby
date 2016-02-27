FactoryGirl.define do

  factory :product do
    sequence(:code) {|n| "AUTO00#{n}" }
    name "Example Product"
    price { BigDecimal.new("9.99") }

    factory :product_001 do
      code "001"
      name "Travel Card Holder"
      price { BigDecimal.new("9.25") }
    end

    factory :product_002 do
      code "002"
      name "Personalised cufflinks"
      price { BigDecimal.new("45.00") }
    end

    factory :product_003 do
      code "003"
      name "Kids T-shirt"
      price { BigDecimal.new("19.95") }
    end
  end

end
