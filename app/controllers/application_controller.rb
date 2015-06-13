class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action do
    memory_usage = `ps -o rss= -p #{Process.pid}`.to_i
    puts "Ruby process memory usage #{memory_usage} KB"
  end
end
