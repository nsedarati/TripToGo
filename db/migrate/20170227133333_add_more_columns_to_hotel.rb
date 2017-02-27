class AddMoreColumnsToHotel < ActiveRecord::Migration
  def change
  	 add_column :hotels, :price, :integer
  	 add_column :hotels, :summary, :text
  	 add_column :hotels, :type, :string

  end
end
