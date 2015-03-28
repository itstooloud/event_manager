require 'csv'
puts "Event manager initialized!"


#contents = File.open("event_attendees.csv").read
#puts contents
=begin
METHOD PRIOR TO USING RUBY'S BUILT-IN CSV FUNCTION	

lines = File.readlines "event_attendees.csv"

lines.each_with_index do |line, index|
	next if index == 0
	columns = line.split(",")
	name = columns[2]
	puts name
end

=end

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
	name = row[:first_name]
	zipcode = row[:zipcode]
	if zipcode.nil?
		zipcode = "00000"
	elsif zipcode.length > 5
		zipcode = zipcode.match(/...../)
	elsif zipcode.length < 5
		zipcode = zipcode.rjust 5, "0"
	end
		
	puts "#{name}  #{zipcode}"

end
