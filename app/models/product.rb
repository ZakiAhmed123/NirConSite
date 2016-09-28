class Product < ActiveRecord::Base
   has_many :order_items
   validates :name, :img_file, :price, :shipping_cost, :info_1, :info_2, :info_3, presence: true

   scope :with_flange, lambda { |flanges|
   where(flange: [*flanges])
  }

   filterrific(
      default_settings: { sorted_by: 'flange_desc' },
      available_filters: [
        :sorted_by,
        :search_query,
        :with_flange
      ]
    )
end
