class User < ApplicationRecord
  USER_TYPES = %w[business volunteer organization].freeze

  scope :businesses, -> { where(user_type: "business") }
  scope :volunteers, -> { where(user_type: "volunteer") }
  scope :organizations, -> { where(user_type: "organization") }

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :omni_auth_identities, dependent: :destroy
  has_many :user_quests
  has_many :quests, through: :user_quests
  has_one :profile, dependent: :destroy

  validates :email_address, presence: true,
              format: { with: URI::MailTo::EMAIL_REGEXP },
              uniqueness: { case_sensitive: false }

  validates :password, on: [ :registration, :password_change ],
            presence: true,
            length: { minimum: 8, maximum: 72 }

  validates :user_type, presence: true, inclusion: { in: %w[business volunteer organization] }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def dashboard_path
    case user_type
    when "business"
      Rails.application.routes.url_helpers.business_dashboard_path
    when "volunteer"
      Rails.application.routes.url_helpers.volunteer_dashboard_path
    when "organization"
      Rails.application.routes.url_helpers.organization_dashboard_path
    else
      Rails.application.routes.url_helpers.root_path
    end
  end

  def can_apply_for?(quest)
    return false unless volunteer?

    UserQuest.where(user: self, quest: quest).empty? && Application.where(applicant: self, quest: quest).empty?
  end

  def self.find_by_email(email)
    find_by(email_address: email.strip.downcase)
  end

  def self.create_from_registration(params)
    user = self.new(params)
    user.save
    user
  end

  def self.create_from_oauth(auth)
    email = auth.info.email
    user = self.new email_address: email, password: SecureRandom.base64(64).truncate_bytes(64)
    # TODO: you could save additional information about the user from the OAuth sign in
    # assign_names_from_auth(auth, user)
    user.save
    user
  end

  def signed_in_with_oauth(auth)
    # TODO: same as above, you could save additional information about the user
    # User.assign_names_from_auth(auth, self):_
    # save if first_name_changed? || last_name_changed?
  end

  def volunteer?
    user_type == "volunteer"
  end

  def organization?
    user_type == "organization"
  end

  def business?
    user_type == "business"
  end
end
