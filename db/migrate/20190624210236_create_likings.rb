class CreateLikings < ActiveRecord::Migration[5.2]
  def change
    create_table :likings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :entry, foreign_key: true

      t.timestamps
    end
  end
end
