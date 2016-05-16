# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Geo < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   geo {
  #     point => {
  #       "field" => "field_name_to_add",
  #       "lat" => "%{lat}",
  #       "lon" => "%{lon}"
  #   }
  # }
  #
  config_name "geo"
  
  # Replace the message with this value.
  config :point, :validate => :hash, :default => {}
  config :field, :validate => :string, :default => {}
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    if @point
      # Replace the event message with our message as configured in the
      # config file.
      event[@field] = [ event["lon"].to_f, event["lat"].to_f ]
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example
