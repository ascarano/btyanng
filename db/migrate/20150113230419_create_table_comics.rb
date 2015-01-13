class CreateTableComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string "comic_data"
      t.timestamps
    end
  end
end
