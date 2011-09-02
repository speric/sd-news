class Item < ActiveRecord::Base
	validates :title, :presence => true
	validates :url, :uniqueness => true
	
	has_many :comments, :dependent => :destroy
	belongs_to :user
	
  cattr_reader :per_page
  @@per_page = 25

	before_save :parse_host_from_url
  
	def parse_host_from_url
		self.url_host = "news.sensusdivinitatis.com" if self.url.empty?
  
   	parsed_url = URI.parse(self.url)
  
   	self.url_host = "cal.vini.st" if parsed_url.host == "cal.vini.st"
  
   	foo = parsed_url.host.split(".")
   	if foo[1] == "wordpress" or foo[1] == "blogspot" or foo[1] == "posterous" or foo[1] == "typepad" or foo[1] == "blogs" or foo[1] == "squarespace"
			self.url_host = foo.join(".")
		elsif foo.last == "uk"
			self.url_host = foo[foo.length - 3, foo.length].join(".")
		else
			self.url_host = foo[foo.length - 2, foo.length].join(".")
		end
  end
end