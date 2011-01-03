class UserMailer < ActionMailer::Base
  @@sender_address = "dixieepoc@gmail.com"
  cattr_accessor :sender_address

  def registration_confirmation(activation)
    recipients  activation.email
    from        sender_address
    subject     "Please confirm your registration"
    body        :activation => activation
    content_type "text/html"
  end
end
