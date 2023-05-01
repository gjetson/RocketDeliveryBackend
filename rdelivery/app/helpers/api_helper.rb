module ApiHelper
    require 'twilio-ruby'

    # def send_sms(customer_number, customer_name, order_id)
    def send_sms(customer_name, order_id)
        account_sid = 'AC471c9a18639e9bbdc93c2fcda4dd6e9e'
        auth_token = '42c9ca1dc2fc80de0d6156322ac28630'
        @client = Twilio::REST::Client.new(account_sid, auth_token)

        message = @client.messages.create(
        body: "Hi thank you for your order, #{customer_name}. You're Order ID is #{order_id}",
        from: '+18884024260',
        to: '+14086346940'
      
        )

        puts message.sid
    end


end