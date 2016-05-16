# encoding: utf-8
require 'spec_helper'
require "logstash/filters/geo"
require "logstash/filters/csv"

describe LogStash::Filters::Geo do
  describe "Convert two numbers to geo_point" do
    let(:config) do <<-CONFIG
      filter {
        csv {
          columns => ["lat","lon"]
        }
        geo {
          field => "location"
          point => {
            "lat" => "%{lat}"
            "lon" => "%{lon}"
          }
        }
      }
    CONFIG
    end

    sample({ "message" => "42.8929638,-78.8722231"}) do
      expect(subject).to include("location")
      expect(subject['location']).to eq([-78.8722231,42.8929638])
    end
  end
end
