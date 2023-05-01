require 'rubygems'
require 'twilio-ruby'

account_sid = 'AC471c9a18639e9bbdc93c2fcda4dd6e9e'
auth_token = '42c9ca1dc2fc80de0d6156322ac28630'
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages.create(
  body: 'My name is Del ',
  from: '+18884024260',
  to: '+4086346940'
)

puts message.sid