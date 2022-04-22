class Order < ApplicationRecord
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum order_status: { waiting_for_deposit: 0, payment_confirmation: 1, in_the_making: 2,
                                                          preparing_to_ship: 3, shipped: 4 }
    
    has_many :order_details, dependent: :destroy
    belongs_to :customer
end
