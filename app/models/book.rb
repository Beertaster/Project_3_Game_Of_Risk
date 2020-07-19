class Book < ApplicationRecord
    belongs_to :user
    belongs_to :genre   
    has_many :reviews
    has_many :users, through: :reviews 

    #accepts_nested_attributes_for :company

    validates :name, presence: true  
    validates :address, uniqueness: true  
    validate :not_a_duplicate 

    scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')}
    scope :most_popular, -> {left_joins(:reviews).group(:id).order('count(reviews.id) desc').limit(3)}  

    def self.alpha
        order(:name) 
    end

    def genre_attributes=(attributes)
        self.genre = Genre.find_or_create_by(attributes) if !attributes['name'].empty?
        self.genre 
    end

    def not_a_duplicate
        # if there is already a book with this name and address 
        book = Book.find_by(name: name, address: address) 
        if !!book && book != self
          errors.add(:name, 'has already been added for that address')
        end
    end 

    def genre_name
        genre.try(:name)
      end
    
      def name_and_genre
        "#{name} - #{genre.try(:name)}"
      end
 
      
end