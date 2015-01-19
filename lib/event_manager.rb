require 'csv'
require 'sunlight/congress'
require 'erb'
require 'pry'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
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

@registration_hours = []

def format_time(time)
  DateTime.strptime(time, "%m/%d/%y %k:%M")
end

def group_registration_by_hour
  @registration_hours.group_by { |time| time.hour }
end

def print_registration_by_hour
  max_hours = group_registration_by_hour.values.max { |a, b| a.length <=> b.length }.length
  group_registration_by_hour.select { |k, v| v.length  >= max_hours }.each do |k, v|
    puts v[0].strftime("The busiest registration hour(s): %l%p")
  end
end

def group_registration_by_weekday
  @registration_hours.group_by { |time| time.wday } 
end

def print_registration_by_weekday
  max_days = group_registration_by_weekday.values.max { |a, b| a.length <=> b.length }.length
  group_registration_by_weekday.select { |k, v| v.length >= max_days }.each do |k, v|
    puts v[0].strftime("The busiest registration day(s): %A")
  end
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read("form_letter.erb")

erb_template = ERB.new(template_letter)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  numbers = row[:homephone]
  time = row[:regdate]

  @registration_hours << format_time(time)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end	
