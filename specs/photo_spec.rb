require('minitest/autorun')
require('minitest/rg')
require_relative('../models/photo.rb')
require_relative('../models/user.rb')
require_relative('../models/camera.rb')
require_relative('../models/lens.rb')

class TestPhoto < MiniTest::Test

  def setup

    @user = User.new({'id' => 1, 'username' => 'Bobby', 'fullname' => 'Bob Hope', 'isphotographer' => TRUE})
    @camera = Camera.new({'id' => 2, 'make' => 'Sony', 'model' => 'A7S'})
    @lens = Lens.new({'id' => 3, 'make' => 'Sony', 'model' => '24-70mm f4'})
    @photo = Photo.new({'id' => 1, 'name' => 'Sunset', 'object' => 'url', 'datetaken' => '2013-08-26', 'location' => 'Edinburgh', 'aperture' => 2.8, 'shutterspeed' => 100, 'photographer_id' => @user.id, 'camera_id' => @camera.id, 'lens_id' => @lens.id})
  end

  def test_name
    assert_equal('Sunset', @photo.name)
  end

  def test_object
    assert_equal('url', @photo.object)
  end

  def test_datetaken
    assert_equal('2013-08-26', @photo.datetaken)
  end

  def test_location
     assert_equal('Edinburgh', @photo.location)
  end

  def test_aperure
      assert_equal(2.8, @photo.aperture)
  end

  def test_shutterspeed
      assert_equal(100, @photo.shutterspeed)
  end

  def test_photographer_id
      assert_equal(1, @photo.photographer_id)
  end

  def test_camera_id
      assert_equal(2, @photo.camera_id)
  end

  def test_lens_id
      assert_equal(3, @photo.lens_id)
  end

end
