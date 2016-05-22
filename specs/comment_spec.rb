require('minitest/autorun')
require('minitest/rg')
require_relative('../models/photo.rb')
require_relative('../models/user.rb')
require_relative('../models/camera.rb')
require_relative('../models/lens.rb')
require_relative('../models/comment.rb')

class TestComment < MiniTest::Test

  def setup

    @user = User.new({'id' => 2, 'username' => 'Bobby', 'fullname' => 'Bob Hope', 'isphotographer' => TRUE})
    @camera = Camera.new({'id' => 2, 'make' => 'Sony', 'model' => 'A7S'})
    @lens = Lens.new({'id' => 3, 'make' => 'Sony', 'model' => '24-70mm f4'})
    @photo = Photo.new({'id' => 3, 'name' => 'Sunset', 'object' => 'url', 'datetaken' => '2013-08-26', 'location' => 'Edinburgh', 'aperture' => 2.8, 'shutterspeed' => 100, 'photographer_id' => @user.id, 'camera_id' => @camera.id, 'lens_id' => @lens.id})
    @comment = Comment.new({'id' => 1, 'user_id' => @user.id, 'photo_id' => @photo.id, 'rating' => 5, 'post' => 'Great Work!'})
  end

  def test_id
    assert_equal(1, @comment.id)
  end

  def test_user_id
    assert_equal(2, @comment.user_id)
  end

  def test_photo_id
    assert_equal(3, @comment.photo_id)
  end

  def test_rating
     assert_equal(5, @comment.rating)
  end

  def test_post
      assert_equal('Great Work!', @comment.post)
  end

end
