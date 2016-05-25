class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, null: false
      t.string :email, null: false
      t.string :phone
      t.string :website

      t.timestamps null: false
    end
  end
end
