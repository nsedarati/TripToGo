class ImageChangeString < ActiveRecord::Migration
  def change
    change_column :users, :image, :string
  end
end
