class ApplicationMailer < ActionMailer::Base
  default from: "rails@rails-unicorn-nginx"
  layout 'mailer'
end
