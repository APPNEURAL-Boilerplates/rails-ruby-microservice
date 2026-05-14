# frozen_string_literal: true

class ItemsService
  def initialize(repository: ItemsRepository.new, event_publisher: EventPublisher.new)
    @repository = repository
    @event_publisher = event_publisher
  end

  def list
    @repository.all
  end

  def find(id)
    @repository.find(id)
  end

  def create(attributes)
    item = @repository.create(attributes)
    @event_publisher.publish('item.created', ItemSerializer.new(item).as_json)
    item
  end
end
