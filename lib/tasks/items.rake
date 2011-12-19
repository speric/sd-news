namespace :talent do
  desc "Update Item scores based on votes, age, etc."
  task(:update_item_scores => :environment) do
  	time = Time.now
	Item.all.includes(:votes).each do |item|
		elapsed = item.created_at - time
		item.score = Math.log10(item.votes.size - .999) + (elapsed / 45000)
		item.save 
	end
  end
end