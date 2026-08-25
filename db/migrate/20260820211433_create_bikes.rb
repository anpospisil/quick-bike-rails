class CreateBikes < ActiveRecord::Migration[8.1]
  def change
    create_table :bikes do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.boolean :reserved
      t.boolean :locked
      t.integer :lock_code

      t.timestamps
    end
  end
end
