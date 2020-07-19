class Genre < ApplicationRecord
    has_many :restaurants 

    validates :name, presence: true, uniqueness: true  

    scope :alpha, -> {order(:name)} 

end