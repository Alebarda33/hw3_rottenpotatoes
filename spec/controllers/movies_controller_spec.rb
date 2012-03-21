require 'spec_helper'

describe MoviesController do
  describe 'Find Similar Movies' do
    before :each do
      @fake_results = [mock(Movie),mock(Movie)]
      @fake_movie = Movie.create!(:title => "Fake title",
                                     :id =>"Fake_id", :director => "Fake director")

    end
    it 'should call the model method that performs search by director' do
       Movie.should_receive(:find_all_by_director).with(@fake_movie.director).
        and_return (@fake_results)
      get  :by_director, {:movie_id => @fake_movie.id}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_all_by_director).and_return(@fake_results)
        get :by_director, {:movie_id => @fake_movie.id}
      end

      it 'should select the Search Results template for rendering' do
         response.should render_template('by_director') 
      end

      it 'should make the search results available to this template' do
        assigns(:movies).should == @fake_results
      end
    end
    describe 'after empty search' do
      before :each do
        fake_movie = Movie.create!(:title => "Fake title",
                                     :id =>"Fake", :director => "")

        Movie.stub(:find_all_by_director).and_return("")
        get :by_director, {:movie_id => fake_movie.id} 
      end
      it 'should select the index template for rendering' do
        response.should redirect_to movies_path
      end
    end
  end

end
