class AddEmotionToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :emotion, :string, default: "happy"
  end
end
