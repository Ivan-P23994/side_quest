class Mission < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :quests, dependent: :destroy
  has_many :quest_rewards, through: :quests

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 600 }
  validates :owner, presence: true
end
