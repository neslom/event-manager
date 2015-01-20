require './lib/event_manager'

describe EventManager do
  attr_reader :event
  before do
    @event = EventManager.new
  end

  it "exists" do
    expect(event).to be_truthy
  end
end
