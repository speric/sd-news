class Item < ActiveRecord::Base
	validates_presence_of :title, :message => "Item title is required."
	validates_presence_of :description, :message => "Please enter a short description."
	validates_uniqueness_of :url, :message => "That link has already been posted."
	validates_length_of :description, :maximum => 350, :message => "Please limit the description or excerpt to 350 characters."
	
	has_many :comments
	belongs_to :user
	
  #will_paginate stuff
  cattr_reader :per_page
  @@per_page = 25
end