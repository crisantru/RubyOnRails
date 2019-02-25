class CreatePerteneces < ActiveRecord::Migration
  def change
    create_table :perteneces do |t|
      t.references :pokemon, index: true, foreign_key: true
      t.references :type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
