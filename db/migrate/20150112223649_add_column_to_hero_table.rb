class AddColumnToHeroTable < ActiveRecord::Migration
  def change
    add_column :heroes, :marvel_data, :string
  end
end
