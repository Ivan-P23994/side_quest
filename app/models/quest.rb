class Quest < ApplicationRecord
  belongs_to :mission
  has_many :quest_rewards
  has_many :user_quests, dependent: :destroy
end
