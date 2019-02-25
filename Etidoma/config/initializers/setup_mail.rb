#ActionMailer::Base.smtp_settings = {
#  :address              => 'smtp.gmail.com',
#  :port                 => 587,
#  :domain               => 'etidoma-crisantru.rhcloud.com',
#  :user_name            => ENV['gmail_username'],
#  :password             => ENV['gmail_password'],
#  :authentication       => :plain,
#  :enable_starttls_auto => true,
#  :openssl_verify_mode  => 'none'
#}

ActionMailer::Base.smtp_settings = {
 :address        => 'smtp.sendgrid.net',
 :port           => '587',
 :authentication => :plain,
 :user_name      => 'crisantru',
 :password       => 'Nocturnal2802',
 :domain         => 'rhcloud.com',
 :enable_starttls_auto => true,
 :openssl_verify_mode  => 'none'
}
