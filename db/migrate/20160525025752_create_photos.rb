class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :album, index: true, foreign_key: true
      t.string :title, null: false
      t.string :url
      t.string :thumbnailUrl

      t.timestamps null: false
    end
  end
end
