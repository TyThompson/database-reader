require "./db/setup"
require "./lib/all"
# Prompts the user for their name
# Displays a list of available items
# Asks the user to choose an item
# Asks the user for a quantity
# Creates a new order for that user / item / quantity

user = get_name
pick_item user

while purchase_another?
  pick_item user
end
