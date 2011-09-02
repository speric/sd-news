class ItemsController < ApplicationController
	before_filter :require_user, :only => [:new, :create, :edit, :update]
	before_filter :require_admin, :only => :destroy
  # GET /items
  # GET /items.xml
  def index
   	@page = params[:page].to_i || 0
   	if params[:user_id].blank?
   		@items = Item.page(params[:page]).order('score desc').includes(:user, :comments)
			@title = "Page #{@page}" if @page > 1
		else
			@user = User.find_by_name(params[:user_id])
			@items = Item.page(params[:page]).where(:user_id => @user.id).order('posted_on desc').includes(:user)
			if @page > 1
				@title = "#{@user.name}'s Submissions | Page #{@page}" if @page > 1
			else
				@title = "#{@user.name}'s Submissions"
			end
		end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id], :include => [:user, :comments])
		@comment = Comment.new
		
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Submission successful') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /items/newest
  # GET /items/newest.xml
  def newest
 		@page = params[:page].to_i || 0
		@items = Item.page(params[:page]).order('posted_on desc').includes(:user)
		@title = "Page #{@page}" if @page > 1
    respond_to do |format|
      format.html { render :template => "items/index" }
      format.xml  { render :xml => @items }
    end 	
	end
end
