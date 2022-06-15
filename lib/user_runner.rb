require_relative 'gofish_user' 
require 'pry'

user = GoFishUser.new()
while true 
  message = user.recieve_message
  if user.requires_input?(message)
    response = STDIN.gets
    user.send_message(response)
  end

end
