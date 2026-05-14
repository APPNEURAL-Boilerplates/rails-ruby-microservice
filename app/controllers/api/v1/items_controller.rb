# frozen_string_literal: true

module API
  module V1
    class ItemsController < ApplicationController
      def index
        items = items_service.list

        render_success(data: items.map { |item| ItemSerializer.new(item).as_json })
      end

      def show
        item = items_service.find(params[:id])

        render_success(data: ItemSerializer.new(item).as_json)
      end

      def create
        item = items_service.create(create_params)

        render_success(
          data: ItemSerializer.new(item).as_json,
          status: :created
        )
      end

      private

      def items_service
        @items_service ||= ItemsService.new
      end

      def create_params
        source = params[:item].present? ? params.require(:item) : params
        source.permit(:name, :description, :price).to_h
      end
    end
  end
end
