class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
    	t.column :name, :string
    	t.column :price, :decimal
    	t.column :meals, :boolean
    	t.column :bagcheck, :boolean
    	t.column :seats, :integer

    	t.timestamps
    end
  end
end
