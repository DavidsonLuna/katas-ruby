# All calculations MUST be done using BigDecimal to avoid Float rounding issues.
require "bigdecimal"
require "forwardable"

require_relative "./lib/checkout_proxy"
require_relative "./lib/checkout"
require_relative "./lib/checkout_backend"
require_relative "./lib/item"
require_relative "./lib/product"

Dir["./lib/promotions/*.rb"].each do |f|
  require_relative "./lib/promotions/#{File.basename(f)}"
end
