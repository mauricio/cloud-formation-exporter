require "cloud_formation/exporter/version"

module CloudFormation
  module Exporter

    def base_template(resources = {})
      {
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Resources" => resources
      }
    end

    module_function :base_template

  end
end
