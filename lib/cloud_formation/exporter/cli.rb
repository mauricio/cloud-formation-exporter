require 'thor'
require 'cloud_formation/exporter/sqs'

module CloudFormation
  module Exporter
    class CLI < Thor

      desc 'sqs', 'Produces the JSON for the given SQS resources'
      option :prefix, :aliases => :p, :desc => 'Uses the prefix to filter the exported queues'

      def sqs
        jj CloudFormation::Exporter::SQS.new(options[:prefix]).generate_template
      end

    end
  end
end