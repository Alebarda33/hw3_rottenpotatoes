class AddDirectorMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string
    Movie.all.each do |movie|
      movie.update_attributes! :director => ''
    end
  end

end
