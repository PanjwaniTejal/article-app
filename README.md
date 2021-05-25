## Ruby version 2.5.1
## Rails version 5.2.6

Create new rails application for API using below command:
rails new article-app --api

creating new application using --api this will not generating any middleware such as view, helper, asserts. 
And ApplicationController inherit from ActionController::API instead of ActionController::Base 

Steps:
1)  rails g model user email password_digest confirmation_token confirmed_at confirmation_sent_at
2)  rails db:migrate
3)  gem 'bcrypt'
4)  gem 'letter_opener'
5)  rails g job send_confirmation_instruction
6)  rails generate mailer UserMailer
7)  gem 'sidekiq'
8)  rails g controller registrations
9)  rails g controller sessions
10) gem 'jwt'
11) rails g model article title description user:references
12) rails g controller articles

## gem 'letter_opener'
Open letter is used for the set delivery method into development.rb when email is being sent.
Add below configuration into config/environments/development.rb 

config.action_mailer.delivery_method = :letter_opener
config.action_mailer.perform_deliveries = true

Create a job to send an email confirmation. I used sidekiq as a background job to send emails.
  gem 'sidekiq'
run bundle install. Set your queuing backend after installing the background job.
add queue_adapter into config/application.rb
  config.active_job.queue_adapter = :sidekiq

I've been using action mailer to deliver emails.
  rails generate mailer UserMailer

Now UserMailer has a confirmation_notify method. And under app/views/user_mailer/, build confirmation notify.html.erb


Setup to local:
1) clone it in local
2) bundle install
3) rails db:create db:migrate
Ready Go !!!