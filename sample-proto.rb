#
# Original by Kay Ehni
# https://github.com/ehnik/binary-parser
# 2017-10-25
#

log = 'byte-reader/data.dat'

magic_string = IO.binread(log, 4) #returns 4-byte magic string "MP57"

#Note: Ruby's 'unpack' method returns decoded values in an array; since unpack
#is being called on a single value, the value is at index 0 of the array.
version = IO.binread(log,1,4).unpack('C')[0] #returns 1-byte version number

records = IO.binread(log,4,5).unpack('N')[0] #returns 4-byte number of records

offset = 9 #the header is 9 bytes total, so the records start at a 9-byte offset

def processRecords(file, offset,records) #parses transaction log records and returns answers to questions

  checked_records = 0
  total_debit = 0
  total_credit = 0
  autopay_starts = 0
  autopay_ends = 0
  question_5_balance = 0

  while checked_records<=records #processes each record in log according to question metrics

    record = Hash.new

    #adds enum, timestamp, and ID to record
    record['enum']= IO.binread(file, 1, offset).unpack('h')[0]
    offset = offset + 1
    record['timestamp'] = IO.binread(file, 4, offset).unpack('N')[0]
    offset = offset + 4
    record['id'] = IO.binread(file, 8, offset).unpack('Q>')[0]
    offset = offset + 8

    #performs enum-specific behavior
    case record['enum']
    when "0" #if enum = 0x00, finds balance and adds it to debit total
      record['balance'] = IO.binread(file, 8, offset).unpack('G')[0]
      offset = offset + 8
      total_debit+=record['balance']
    when "1" #if enum = 0x01, finds balance and adds it to credit total
      record['balance'] = IO.binread(file, 8, offset).unpack('G')[0]
      offset = offset + 8
      total_credit+=record['balance']
    when "2" #if enum = 0x02, increments the number of autopay starts
      autopay_starts+=1
    when "3" #if enum = 0x03, increments the number of autopay ends
      autopay_ends+=1
    end

    #checks if record is the one listed in question five
    if record['id'] == 2456938384156277127
      question_5_balance = record['balance']
    end

    checked_records+=1

  end

  answers = {:question_1 => total_debit, :question_2 => total_credit,
  :question_3 => autopay_starts, :question_4 => autopay_ends,
  :question_5 => question_5_balance}

end

puts processRecords(log,offset,records)
