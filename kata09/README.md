## Checkout

Implementation of *flexible* checkout system that allows for items to be scanned, discounts applied and a total amount payable to be shown.

Based around http://codekata.com/kata/kata09-back-to-the-checkout/

## Running Tests

There are 2 sets of tests, Unit and Integration. The Unit tests confirm the functionality of each component individually and are used to ensure the domain objects (CheckoutBackend, Item, Product) behave as expected. The Integration tests confirm the test data runs and returns the expected results.

* run `rspec`


## Design Discussion

The problem we are faced with boils down to: we have a checkout that does some basic addition math, but after that, we want to be able to apply any arbitary transformation (promotions) on that basic result in ways we can only begin to imagine - that could be anything from free shipping, injecting additional free items into the checkout, discounting based on any concievable logic, etc.

We take the position that the CheckoutBackend, Item and Product expose a fixed DSL, and that we are able to encapsulate them within our promotions stack. We may use of the Proxy pattern in order to produce a "Russian Doll" effect, with a chain that looks like:

Checkout -> PromotionA -> PromotionB -> CheckoutBackend.

The `Checkout` class is a wrapper for constructing the stack. Any number of promotions may sit between the `Checkout` and the `CheckoutBackend` that is responsible for the core checkout calculations.

Promotions may occur in any order. We adopt the policy that ordering will be controlled by the `promotional_rules` input when the checkout object is instantiated. Each promotion may then consider it's decision to apply (or not) based on the checkout as it finds it after rules before it have been applied.

The method presented is one possible solution to the "discounts in a checkout" problem where flexibility for promotional rules is raised as a key concern.


## Products database

For an online marketplace, here is a sample of some of the products available on the site:

|Product code| Name                   | Price
|------------|------------------------|------
|001         | Travel Card Holder     | £9.25
|002         | Personalised cufflinks | £45.00
|003         | Kids T-shirt           | £19.95

The marketing team want to offer promotions as an incentive for customers to purchase these items.

* If you spend over £60, then you get 10% off your purchase.
* If you buy 2 or more travel card holders then the price drops to £8.50.
* If you buy 3 t-shirt, for the price of 2
* Cheapest item free - Kids tshirt and personalized cufflinks, when you buy 3 or more.

The check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.


The interface to our checkout looks like this (shown in Ruby):

```ruby
  co = Checkout.new(promotional_rules)
  co.scan(item)
  co.scan(item)
  price = co.total
```

Implement a checkout system that fulfills these requirements.

Test data
---------
* Basket: 001,002,003
  * Total price expected: £66.78
* Basket: 001,003,001
  * Total price expected: £36.95
* Basket: 001,002,001,003
  * Total price expected: £73.76

