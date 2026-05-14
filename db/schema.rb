# frozen_string_literal: true

ActiveRecord::Schema[8.1].define(version: 20_260_514_000_000) do
  create_table 'items', id: :string, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'description'
    t.decimal 'price', precision: 12, scale: 2, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
