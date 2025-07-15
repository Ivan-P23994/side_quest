require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user with correct attributes" do
    user = User.new(
      email_address: "test@example.com",
      password_digest: "hashedpassword",
      user_type: "business"
    )
    assert user.valid?
  end

  test "invalid without email_address" do
    user = User.new(
      password_digest: "hashedpassword",
      user_type: "business"
    )
    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "invalid without user_type" do
    user = User.new(
      email_address: "test@example.com",
      password_digest: "hashedpassword"
    )
    assert_not user.valid?
    assert_includes user.errors[:user_type], "can't be blank"
  end

  test "invalid user_type outside allowed list" do
    user = User.new(
      email_address: "test@example.com",
      password_digest: "hashedpassword",
      user_type: "random_type"
    )
    assert_not user.valid?
    assert_includes user.errors[:user_type], "is not included in the list"
  end

  test "invalid with duplicate email_address" do
    User.create!(
      email_address: "test@example.com",
      password_digest: "hashedpassword",
      user_type: "volunteer"
    )
    user = User.new(
      email_address: "test@example.com",
      password_digest: "hashedpassword",
      user_type: "organization"
    )
    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end
end
