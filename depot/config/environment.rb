# Load the rails application
#encoding "UTF-8"
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Depot::Application.initialize!

Time::DATE_FORMATS[:ru_datetime] = "%d %b, %a, %k:%M"
