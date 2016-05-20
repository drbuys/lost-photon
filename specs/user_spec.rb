require('minitest/autorun')
require('minitest/rg')
require_relative('../models/user.rb')

class TestUser < MiniTest::Test

  def setup
    options = {'username' => 'Bobby', 'fullname' => 'Bob Hope', 'isphotographer' => TRUE}
    @user = User.new(options)
  end

  def test_username
    assert_equal('Bobby', @user.username)
  end

  def test_fullname
    assert_equal('Bob Hope', @user.fullname)
  end

  def test_isphotographer?
    assert_equal(TRUE, @user.isphotographer)
  end

  # def test_photographers
  #     assert_equal(@user, User.photographers)
  # end

end
