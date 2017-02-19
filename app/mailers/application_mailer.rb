class ApplicationMailer < ActionMailer::Base
	default_url_options[:host] = "localhost:3000"
  default from: "http://www.TripToGo.com"
  layout 'mailer'

end
