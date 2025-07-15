require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      email_address: "test@example.com",
      password: "password123",
      user_type: "volunteer"
    )
    @profile = Profile.new(
      user: @user,
      website: "https://example.com",
      phone_number: "+1234567890",
      country: "USA",
      city: "New York",
      about_me: "I love volunteering!",
      username: "testuser"
    )
  end

  test "valid profile" do
    assert @profile.valid?
  end

  test "invalid without user" do
    @profile.user = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:user], "must exist"
  end

  test "username should be present" do
    @profile.username = ""
    assert_not @profile.valid?
    assert_includes @profile.errors[:username], "can't be blank"
  end

  test "website should be valid format if present" do
    @profile.website = "invalid-url"
    assert_not @profile.valid?, "profile should be invalid with bad website URL"
  end

  test "optional fields can be blank" do
    @profile.website = ""
    @profile.phone_number = ""
    @profile.about_me = ""
    assert @profile.valid?
  end

  test "belongs to user" do
    assert_equal @user, @profile.user
  end
end
