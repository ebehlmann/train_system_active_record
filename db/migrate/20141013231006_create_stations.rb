class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
    	t.column :name, :string
    	t.column :location, :string
    	t.column :restaurant, :boolean
    	t.column :opens, :time

    	t.timestamps
    end
  end
end
