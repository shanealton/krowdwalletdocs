#  Copyright (c) 2012 Apple, Inc. All rights reserved.

require './pass_server'

# Used to implement HTTP PUT and DELETE with HTTP POST and _method
use Rack::MethodOverride

# Pass Server Settings
PassServer.set :hostname, "104.131.28.86"
PassServer.set :port, 4567
PassServer.set :pass_type_identifier, ENV["PASS_TYPE_ID"]
PassServer.set :team_identifier, ENV["TEAM_ID"]

# Ask user for certificate password
puts "Please enter your certificate password: "
password_input = gets.chomp
PassServer.set :certificate_password, password_input

run PassServer
