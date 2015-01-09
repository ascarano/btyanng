class CreateHeroesTable < ActiveRecord::Migration
  def change
    create_table :heroes do |t|
      t.string "marvel_id"
      t.string "name"
      t.timestamps
    end
  end
end
