require 'aws/core/inflection'
require 'aws/sqs'
require 'cloud_formation/exporter'
require 'json'

module CloudFormation
  module Exporter
    class SQS

      include CloudFormation::Exporter

      FIELDS = [
        "DelaySeconds",
        "MaximumMessageSize",
        "MessageRetentionPeriod",
        ["ReceiveMessageWaitTimeSeconds", 'wait_time_seconds'],
        "VisibilityTimeout"
      ]

      def initialize(prefix = nil)
        @prefix = prefix
        @client = AWS::SQS.new
      end

      def resources
        filtered_queues.inject({}) do |acc, queue|
          name = queue.url.split("/").last
          result = FIELDS.inject({}) do |properties, (field,mapping)|
            properties[field] = queue.send(to_ruby_name(mapping || field))
            properties
          end
          result['QueueName'] = name
          acc[generate_name(name)] = {
            "Type" => "AWS::SQS::Queue",
            "Properties" => result
          }
          acc
        end
      end

      def filtered_queues
        if @prefix
          @client.queues.with_prefix(@prefix)
        else
          @client.queues
        end
      end

    end
  end
end