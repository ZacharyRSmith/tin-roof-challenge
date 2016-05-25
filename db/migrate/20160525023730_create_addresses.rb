class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
