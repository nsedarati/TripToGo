class Notifier < ApplicationMailer

	  # send a signup email to the user, pass in the user object that   contains the user's email address
  default from: 'sedaratiniloufar@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    mail(to: @user.email,
    subject: 'Welcome to My Awesome Site') do |format|
      format.html { render '/notifier/welcome_email.html.erb' }
      format.text { render text: '/notifier/welcome_email.text.erb' }
    end
  end

  
	def password_reset(user)
  @user = user
  mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
       subject: "Reset Your Password")
end
end
