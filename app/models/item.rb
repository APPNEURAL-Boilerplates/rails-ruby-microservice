# frozen_string_literal: true

require 'securerandom'

class Item < ApplicationRecord
  before_validation :set_id, on: :create

  validates :name, presence: true, length: { maximum: 120 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def set_id
    self.id ||= SecureRandom.uuid
  end
end
