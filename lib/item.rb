class Item < ActiveRecord::Base
  belongs_to :purchase

  # def price
  #   super to_f
  # end

end
