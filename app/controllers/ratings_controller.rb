class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @best_beers = Beer.top(3)
    @best_breweries = Brewery.top(3)
    @most_active_users = User.top(3)
    @recent_ratings = Rating.recent
    @best_styles = Style.top(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end