class CreateTributes < ActiveRecord::Migration
  def change
    create_table :tributes do |t|
      t.string :name
      t.text :obituary
      t.date :dobirth
      t.date :dodeath
      t.integer :user_id

      t.timestamps
    end
    add_index :tributes, [:user_id, :name]
  end
end
