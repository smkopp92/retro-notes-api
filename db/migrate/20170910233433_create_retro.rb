class CreateRetro < ActiveRecord::Migration[5.0]
  def change
    create_table :retros do |t|
      t.string :name, null: false
    end
    add_column :notes, :retro_id, :integer, null: false
  end
end
