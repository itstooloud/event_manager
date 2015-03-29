=begin

Similar to the zip codes the phone numbers suffer from multiple formats and inconsistencies. If we wanted to allow individuals to sign up for mobile alerts with the phone numbers we would need to make sure all of the numbers are valid and well-formed.

If the phone number is less than 10 digits assume that it is a bad number
If the phone number is 10 digits assume that it is good
If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
If the phone number is 11 digits and the first number is not 1, then it is a bad number
If the phone number is more than 11 digits assume that it is a bad number


=end

require 'csv'
require 'date'

file = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

def clean_phone(phone_number)

phone = phone_number.scan(/\d+/).join
#puts "phone : " + phone.to_s
#puts phone.length

if phone.length < 10
	return_phone = "0000000000"
end

if phone.length == 11 && phone[0] == "1"
	return_phone = phone[0..9]
end

if phone.length == 11 && phone[0] != "1"
	return_phone = "0000000000"
end

if phone.length > 11 
	return_phone = "0000000000"
end

if phone.length == 10
	return_phone = phone
end

return_phone = return_phone[0..2] + "-" + return_phone[3..5] + "-" + return_phone[6..9]
end

#puts clean_phone("123er45&&67$#---892220")


def reg_hour(this_time)
	t = DateTime.strptime(this_time, '%m/%d/%Y %H:%M')
	t.hour
end

def reg_day(this_time)
	t = DateTime.strptime(this_time, '%m/%d/%Y %H:%M')
	t.wday
end

reg_per_hour = Hash.new(0)
reg_per_day = Hash.new(0)

file.each do |file|
	puts file[:first_name] 
	puts clean_phone(file[:homephone])
	puts file[:regdate]
	#puts reg_hour(file[:regdate])
	#puts reg_day(file[:regdate])
	
	reg_per_hour[reg_hour(file[:regdate])] += 1
	reg_per_day[reg_day(file[:regdate])] += 1
	

end

puts reg_per_hour.sort_by {|key,value| value}.reverse
puts reg_per_day.sort_by {|key,value| value}.reverse




