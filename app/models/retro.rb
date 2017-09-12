class Retro < ActiveRecord::Base
  has_many :notes, dependent: :destroy

  validates :name, presence: true
end
