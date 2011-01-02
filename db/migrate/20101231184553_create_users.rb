class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.boolean :activated
      t.datetime :birthdate
      t.string :address
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
