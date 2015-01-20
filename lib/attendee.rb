class Attendee
  attr_accessor :first_name, :last_name, :phone_number
  def initialize(data={})
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @phone_number = clean_phone_numbers(data[:phone_number])
  end

  def number_formatter(number)
    [3, 7].each { |x| number.insert(x, "-") }
    number
  end

  def clean_phone_numbers(number)
    return "-" if number.nil?
    number.to_s.gsub!(/\D/, "")
    if number.length == 10
      number_formatter(number)
    elsif number.length == 11 && number[0] == "1"
      number[0] = ""
      number_formatter(number)
    else
      "-"
    end
  end

end
