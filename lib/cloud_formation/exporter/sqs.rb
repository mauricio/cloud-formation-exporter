require 'aws/core/inflection'
require 'aws/sqs'
require 'cloud_formation/exporter'
require 'json'

module CloudFormation
  module Exporter
    class SQS

      FIELDS = [
        "DelaySeconds",
        "MaximumMessageSize",
        "MessageRetentionPeriod",
        ["ReceiveMessageWaitTimeSeconds", 'wait_time_seconds'],
        "VisibilityTimeout"
      ]

      def initialize(*args)
        @client = AWS::SQS.new(*args)
      end

      def queues
        @client.queues.inject({}) do |acc, queue|
          name = queue.url.split("/").last
          acc[name] = FIELDS.inject({}) do |properties, (field,mapping)|
            properties[field] = queue.send(AWS::Core::Inflection.ruby_name(mapping || field))
            properties
          end
          acc
        end
      end

      def to_json
        JSON.pretty_generate(CloudFormation::Exporter.base_template(queues))
      end

    end
  end
end