require "./db/setup"
require "./lib/all"

def get_name
  puts "What is your first name?"
  first_name = gets.chomp.capitalize
  puts "#{first_name}, What is your last name?"
  last_name = gets.chomp.capitalize
  user_object = User.where(first_name: first_name, last_name: last_name).first_or_create!
  user_id = user_object.id
  return user_id
end

def item_list
  Item.order(:category).pluck(:id, :description, :price, :category)
end

def display_items item_list
  puts "Here is a list of our items:"
  item_list.each do |id, description, price, category|
    puts "#{id}) #{description}: $#{price.to_f}, ( #{category} )"
  end
end

def pick_item user_id
  puts "Which item id# would like to purchase? Type 1 to view id#) list."
  pick_id = gets.chomp.to_i
  buy_item = Item.where(id: pick_id).pluck(:description, :price)[0]
  if buy_item == nil
    display_items item_list
    pick_item user_id
  else
    description = buy_item[0]
    price = buy_item[1]
    puts "How many of id# #{pick_id}) #{description} $#{price.round(2).to_f} would you like to purchase?"
    quantity = gets.chomp.to_i
    total = quantity * price.to_f
    puts "Purchasing #{quantity} #{description} for $#{total.round(2).to_f}."
    hit_the_red_button = Purchase.create(user_id: user_id, item_id: pick_id, quantity: quantity)
  end
end


def purchase_another?
  puts "Would you like to purchase something else? y/n"
  input = gets.chomp.downcase
  if input == "y" || input == "yes"
    return true
  else
    return false
  end
end
