class Item < ActiveRecord::Base
	validates :title, :presence => true
	validates :url, :uniqueness => true, :unless => "url.blank?"
	
	has_many :comments, :dependent => :destroy
	has_many :votes, :dependent => :destroy
	belongs_to :user
	
  	cattr_reader :per_page
  	@@per_page = 25

	before_create :parse_host_from_url
	after_create :create_vote

	def parse_host_from_url
		if self.description.blank?
			parsed_url = URI.parse(self.url)
	  
	   		self.url_host = "cal.vini.st" if parsed_url.host == "cal.vini.st"
	  
	   		host = parsed_url.host.split(".")
	   		if host[1] == "wordpress" or host[1] == "blogspot" or host[1] == "posterous" or host[1] == "typepad" or host[1] == "blogs" or host[1] == "squarespace"
				self.url_host = host.join(".")
			elsif host.last == "uk"
				self.url_host = host[host.length - 3, host.length].join(".")
			else
				self.url_host = host[host.length - 2, host.length].join(".")
			end
		else
	  		self.url_host = "news.sensusdivinitatis.com"
		end
  	end

  	def create_vote
  		Vote.create(:user_id => self.user_id, :item_id => self.id)
  	end
end