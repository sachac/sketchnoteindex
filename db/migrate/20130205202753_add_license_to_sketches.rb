class AddLicenseToSketches < ActiveRecord::Migration
  def change
    add_column :sketches, :license, :string
  end
end
