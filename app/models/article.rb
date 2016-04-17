class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :title, 
				presence: true, 
				length: {minimum: 5}
	validates :text, length: {minimum: 3}
end
