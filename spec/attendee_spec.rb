require './lib/attendee.rb'

describe Attendee do
  attr_reader :attendee
  before do
    @attendee = Attendee.new
  end

  it "exists" do
    expect(attendee).to be_truthy
  end

  context "attendee is initialized from a hash of data" do
    before do
      @data = {:first_name => "George", :last_name => "Washington", :phone_number => "202-455-6677"}
      @attender = Attendee.new(@data)
    end

    it "has a first name" do
      expect(@attender.first_name).to eq(@data[:first_name])
    end

    it "has a last name" do
      expect(@attender.last_name).to eq(@data[:last_name])
    end

    it "has a phone number" do
      expect(@attender.phone_number).to eq(@data[:phone_number])
    end
  end

  context "values can be changed" do
    it "can change first name" do
      data = {:first_name => "George"}
      attender = Attendee.new(data)
      expect(attender.first_name).to eq(data[:first_name])
      attender.first_name = "Thomas"
      expect(attender.first_name).to eq("Thomas")
    end

    it "can change last name" do
      data = {:last_name => "Washington"}
      attender = Attendee.new(data)
      expect(attender.last_name).to eq(data[:last_name])
      attender.last_name = "Smith"
      expect(attender.last_name).to eq("Smith")
    end

    it "can change phone number" do
      data = {:phone_number => "202-455-6677"}
      attender = Attendee.new(data)
      expect(attender.phone_number).to eq(data[:phone_number])
      attender.phone_number = "555-867-5309"
      expect(attender.phone_number).to eq("555-867-5309")
    end
  end

  describe "#clean_phone_numbers(number)" do
    it "cleans a dirty number" do
    attender = Attendee.new(:phone_number => "202.444-9382")
    expect(attender.phone_number).to eq("202-444-9382")
    end
  end 
end
