# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items, id: :string do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :price, precision: 12, scale: 2, null: false

      t.timestamps
    end
  end
end
