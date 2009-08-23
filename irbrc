require 'pp'
require 'rubygems'

alias q exit

load File.expand_path('~/.railsrc') if ENV['RAILS_ENV']

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
  Wirble::Colorize.colors = {
    :symbol        => :red,
    :symbol_prefix => :red,
    :open_string   => :green,
    :string        => :green,
    :close_string  => :green,
    :number        => :blue,
    :keyword       => :cyan,
    :class         => :purple,
  }
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end
