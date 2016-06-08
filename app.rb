# Prompts the user for their name
# Displays a list of available items
# Asks the user to choose an item
# Asks the user for a quantity
# Creates a new order for that user / item / quantity

until purchase_another? false
  get_name
  pick_item
  purchase_another?
end
