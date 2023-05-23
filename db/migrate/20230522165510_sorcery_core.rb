# frozen_string_literal: true

class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: { unique: true }
      t.string :email, null: true, index: { unique: true }
      t.string :password_hash
      t.string :salt

      t.timestamps null: false
    end
  end
end
