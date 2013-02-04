class CreateSketches < ActiveRecord::Migration
  def change
    create_table :sketches do |t|
      t.integer :topic_id
      t.integer :artist_id
      t.string :url
      t.datetime :upload_date

      t.timestamps
    end
  end
end
