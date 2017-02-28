class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :hotels, :type, :hotel_type
  end
end
