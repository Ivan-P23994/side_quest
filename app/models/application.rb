class Application < ApplicationRecord
  belongs_to :quest

  belongs_to :applicant, class_name: "User"
  belongs_to :approver, class_name: "User"

  validate :applicant_must_be_volunteer
  validate :approver_must_be_organization
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }

  private

  def applicant_must_be_volunteer
    errors.add(:applicant, "must be a volunteer") unless applicant&.volunteer?
  end

  def approver_must_be_organization
    errors.add(:approver, "must be an organization") unless approver&.organization?
  end
end
