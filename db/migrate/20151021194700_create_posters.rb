class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :text
      t.string :image

      t.timestamps null: false
    end
  end
end
