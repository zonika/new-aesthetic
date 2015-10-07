class UserMailer < ApplicationMailer
  default from: 'hello@new-aesthetic.com'
  def welcome_email(user)
    @name = user.first_name.capitalize
    @url  = 'https://new-aesthetic.herokuapp.com/'
    mail(to: user.email, subject: 'Welcome to New Aesthetic!')
  end
end
