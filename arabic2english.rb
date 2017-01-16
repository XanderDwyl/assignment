# Check the validity of the arguments passed.
# It only accept 1 parameter
# and length up to 33 characters
if ARGV.empty? or ARGV.length > 1 or ARGV[0].length > 33
  puts "Invalid Arguments!"
  exit
end

# Group the number by hundreds
#
# @param num [string] A string value of ARGV inputs
# @return [string] A flatten array value of group numbers.
def group_by_hundreds(num)
  str =  num.to_i.to_s
  a = []
  str.split(//).reverse.each_slice(3) { |slice| a << slice }

  t = str.length % 3
  t = 3-t if t>0
  for i in 1..t
    a << 0
  end

  new_a = []
  a.each do |item|
    new_a << item
  end

  new_a.flatten.join
end

# Get the value in a hundred form.
#
# @param ones [int] An integer value for ones place.
# @param tens [int] An integer value for tenths place.
# @param hund [int] An integer value for hundredths place.
# @return [string] A string value of a number in a hundred form.
def get_value_by_hundreds(ones, tens, hund)
  common_names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen",  "twenty"]
  num_tenths = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

  xh = %Q(#{common_names[hund]} hundred ) if hund > 0
  xt = num_tenths[tens]
  xo = common_names[ones]
  xo = "" if (ones==0 and tens>0) or (ones==0 and tens==0 and hund>0)
  xt = xt + '-'if !xo.empty? and !xt.empty? and ones > 0

  if xt.empty? and tens > 0
    xt = common_names[%Q(#{tens}#{ones}).to_i]
    xo = ''
  end

  xh = %Q(#{xh}and ) if hund > 0 and ((!xt.empty? and !xo.empty?) or tens==2)

  %Q(#{xh}#{xt}#{xo})
end

def convert_number_to_words(num)
  number_to_words=""
  places = ["", " thousand, ", " million, ", " billion, ", " trillion, ", " quadrillion, ",
    " quintillion, ", " sextillion, ", " septillion, ", " octillion, ", " nonillion, "]
  num = group_by_hundreds(num).to_s

  cut = 0
  num.split(//).each_slice(3) do | slice |
    num_slice = get_value_by_hundreds(slice[0].to_i, slice[1].to_i, slice[2].to_i)
    number_to_words = %(#{num_slice}#{places[cut]}#{number_to_words})
    cut += 1
  end

  number_to_words.sub! ', zero', ''
  number_to_words
end

puts convert_number_to_words(ARGV[0])
