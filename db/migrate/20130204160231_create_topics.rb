class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :people
      t.integer :collection_id

      t.timestamps
    end
  end
end
