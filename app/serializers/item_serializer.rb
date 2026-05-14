# frozen_string_literal: true

class ItemSerializer
  def initialize(item)
    @item = item
  end

  def as_json(*_args)
    {
      id: @item.id,
      name: @item.name,
      description: @item.description,
      price: @item.price.to_s,
      created_at: @item.created_at&.iso8601,
      updated_at: @item.updated_at&.iso8601
    }
  end
end
