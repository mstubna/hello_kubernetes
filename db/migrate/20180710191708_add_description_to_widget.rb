class AddDescriptionToWidget < ActiveRecord::Migration[5.2]
  def change
    add_column :widgets, :description, :string
  end
end
