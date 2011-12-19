namespace :items do
  desc "Update Item scores based on votes, age, etc."
  task(:update_item_scores => :environment) do
  	time = Time.now
	Item.includes(:votes).each do |item|
		elapsed = item.created_at - time
		item.score = Math.log10(1 + item.votes.size - 0.999) + (elapsed / 45000)
		item.save 
	end
  end

  desc "Tweet highest ranked item"
  task(:tweet => :environment) do
  	item = Item.where("user_id = 1 and twittered = 0").order("score desc").last
  	if item.description.blank?
  		Twitter.update("#{item.title} #{item.url}")
  	else
  		Twitter.update("#{item.title} http://news.sensusdivinitatis.com/items/#{item.id}")
  	end
  	item.twittered = true
  	item.save
  end
end