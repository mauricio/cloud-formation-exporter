require "cloud_formation/exporter/version"
require "active_support/core_ext/string/inflections"

module CloudFormation
  module Exporter

    def generate_template
      {
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Resources" => resources
      }
    end

    def generate_name(original)
      original.gsub(/[^A-Za-z0-9]/, '_').camelize
    end

  end
end
