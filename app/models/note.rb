class Note < ActiveRecord::Base
  HAPPY = "happy"
  MEH = "meh"
  SAD = "sad"
  EMOTIONS = [HAPPY, MEH, SAD]

  belongs_to :retro

  validates :emotion, inclusion: { in: EMOTIONS }
end
