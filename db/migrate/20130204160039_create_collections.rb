class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :date_string
      t.date :start_date
      t.string :location

      t.timestamps
    end
  end
end
