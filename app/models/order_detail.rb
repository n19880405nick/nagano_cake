class OrderDetail < ApplicationRecord
    enum making_status: { not_startable: 0, waiting_for_making: 1, making: 2, making_completed: 3 }
    belongs_to :item
    belongs_to :order
end
