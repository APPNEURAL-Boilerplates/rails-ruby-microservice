# frozen_string_literal: true

class ItemsRepository
  def all
    Item.order(created_at: :desc)
  end

  def find(id)
    Item.find(id)
  end

  def create(attributes)
    Item.create!(attributes)
  end
end
