class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if !session.has_key?(:ratings)
      session[:ratings] = Movie.get_all_ratings
    end
    if !session.has_key?(:order_by)
      session[:order_by] = nil
    end

    if !params[:ratings].nil?
      @ratings = params[:ratings].keys
      session[:ratings] = @ratings
    else
      @ratings = session[:ratings]
    end

    if !params[:order_by].nil?
      @order_by = params[:order_by]
      session[:order_by] = @order_by
    else
      @order_by = session[:order_by]
    end

    if @order_by.nil?
      @movies = Movie.where({rating: @ratings})
    else
      @movies = Movie.where({rating: @ratings}).order(@order_by)
    end
    @all_ratings = Movie.get_all_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
