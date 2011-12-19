class VotesController < ApplicationController
before_filter :require_user

  # POST /votes
  def create
    @vote = Vote.new(params[:vote])

    respond_to do |format|
      if @vote.save
        format.html { redirect_to(items_path(@vote.item.id), :notice => 'Your vote has been successfully recorded') }
      else
        format.html { redirect_to(item_path(@vote.item.id), :notice => 'You have already voted for this item') }
      end
    end
  end
end