ActionMailer::Base.delivery_method = :smtp # be sure to choose SMTP delivery
ActionMailer::Base.smtp_settings = {
    :address              => "localhost",
   # :port                 => 587,
    :domain               => "rails-unicorn-nginx",

   # :user_name            => "rails",
   # :password             => "786!@#QWEasd",
 #   :authentication       => "plain",
    :enable_starttls_auto =>  true,
    :openssl_verify_mode => 'none'
  }