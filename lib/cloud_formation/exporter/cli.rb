require 'thor'
require 'cloud_formation/exporter/sqs'
require 'cloud_formation/exporter/ec2_security_group'

# AWS.config(:logger => Logger.new($stdout), :log_level => :debug, :http_wire_trace => true)

module CloudFormation
  module Exporter
    class CLI < Thor

      desc 'sqs', 'Produces the JSON for the given SQS resources'
      option :prefix, :aliases => :p, :desc => 'Uses the prefix to filter the exported queues'
      def sqs
        jj CloudFormation::Exporter::SQS.new(options[:prefix]).generate_template
      end

      desc 'security-groups', 'Produces the JSON for the given EC2 security groups'
      option :filter, :aliases => :f, :desc => 'Filters group names based on this'
      def security_groups
        jj CloudFormation::Exporter::Ec2SecurityGroup.new(options[:filter]).generate_template
      end

    end
  end
end