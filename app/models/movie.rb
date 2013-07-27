class Movie < ActiveRecord::Base
  def Movie.get_all_ratings
    Movie.select(:rating).group(:rating).order(:rating).map do |movie|
      movie.rating
    end
  end
end
