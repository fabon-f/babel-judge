# frozen_string_literal: true

class SorceryExternal < ActiveRecord::Migration[7.0]
  def change
    create_table :external_authentications do |t|
      t.integer :user_id, null: false
      t.string :provider, :uid, null: false

      t.timestamps null: false
    end

    add_index :external_authentications, %i[provider uid]
  end
end
