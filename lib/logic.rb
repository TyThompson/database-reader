def get_name
  puts "What is your first name?"
  first_name = gets.chomp.capitalize
  puts "#{first_name}, What is your last name?"
  last_name = gets.chomp.capitalize
  # User.where(first_name: first_name, last_name: last_name).first_or_create!
end

def item_list
  Item.all.pluck(:id, :description)
end

def display_items item_list
  puts "Here is a list of our items:"
  item_list.each do |id, description|
    puts "#{id}) #{description}"
  end
end

def pick_item
  puts "Which item id# would like to purchase? Type 1 to view id#) list."
  pick_id = gets.chomp.to_i
  if pick_id == 1
    display_items item_list
    pick_item
  else
    description = Item.where(id: pick_id).pluck(:description)[0]
    puts "How much of id# #{pick_id}) #{description} would you like to purchase?"
    quantity = gets.chomp.to_i
    puts "Purchasing #{quantity} of #{pick_id}) #{description}."
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
