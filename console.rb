require "./db/setup"
require "./lib/all"

puts "How many items are there? (74)"
Item.count
puts "What is the most expensive item? (Small Granite Shoes)"
Item.where(price: Item.maximum("price"))

puts "Who lives at 7153 Predovic Falls? (Reinhold Corwin)"
predovic = Address.where(street: "7153 Predovic Falls").pluck(:user_id)
User.where(id: predovic).pluck(:first_name, :last_name)

puts "How many Mediocre Copper Bottles did we sell? (sold 1)"
mediocre = Item.where(description: "Mediocre Copper Bottle" ).pluck(:id)
Purchase.where(item_id: mediocre).pluck(:quantity)

# puts "What is our total revenue (item cost * quantity sold for all purchases)?"
all_purchases = Purchase.all.pluck(:item_id, :quantity)
item_ids = all_purchases.map(&:first)
item_lookup = Item.select(:id, :price).where(id: item_ids).index_by(&:id)

total_revenue = all_purchases.map {|item_id, qty| item_lookup[item_id].price * qty}.reduce(&:+)
total_revenue.to_f
puts "What is our total revenue (item cost * quantity sold for all purchases)? #{total_revenue.to_f}"

# puts "How much did Carmelo Towne spend? (user id 101)"
User.where(first_name: "Carmelo", last_name: "Towne").pluck(:id)  #id 101
Purchase.where(user_id: "101").pluck(:item_id, :quantity)
items_array = Purchase.where(user_id: "101").pluck(:item_id)
amount_purchased = Purchase.where(user_id: "101").pluck(:quantity)
# price_array = []
# items_array.each do |i|
#   price_array << Item.where(id: i).pluck(:price).map(&:to_f)
# end

a = Purchase.where(user_id: 101).pluck(:item_id, :quantity)
item_ids = a.map(&:first)
# item_lookup = Item.select(:id, :price).where(id: item_ids).index_by(&:id)
# used above

answer = a.map {|item_id, qty| item_lookup[item_id].price * qty}.reduce(&:+)
answer.to_f
puts "How much did Carmelo Towne spend? (user id 101) #{answer.to_f}"

# puts "How many users have > 1 address?"
multi_address = Address.select(:user_id).group(:user_id).having("count(*) > 1").count.count
#only doing .count.count because I find it funny.
puts "How many users have > 1 address? #{multi_address}"

binding.pry
