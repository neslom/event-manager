require './lib/event_manager'

describe EventManager do
  attr_reader :event
  before do
    @event = EventManager.new
  end

  it "exists" do
    expect(event).to be_truthy
  end

  #it "opens CSV file" do
    #expect(event[0][0]).to include("Allison")
  #end

  #describe "#clean_zipcode" do
    #it "pads too smalls with zeros" do
      #expect(event.clean_zipcode("123")).to eq("00123")
    #end
  #end

end
