class Vote < ActiveRecord::Base
	belongs_to :item
	validates :user_id, :uniqueness => {:scope => :item_id, :message => "You've already voted for this item"}
end