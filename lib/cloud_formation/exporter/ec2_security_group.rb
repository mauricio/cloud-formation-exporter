require 'aws/ec2'
require 'cloud_formation/exporter'

module CloudFormation
  module Exporter
    class Ec2SecurityGroup
      include CloudFormation::Exporter

      def initialize(filter = nil, *args)
        @filter = filter
        @ec2 = ::AWS::EC2.new(*args)
      end

      def resources
        security_groups.inject({}) do |acc, group|
          properties = {
            "GroupDescription" => group.description,
            "GroupName" => group.name,
          }

          if group.ingress_ip_permissions.first
            properties["SecurityGroupIngress"] =
              to_permissions(group.ingress_ip_permissions)
          end

          acc[generate_name(group.name)] = properties
          acc
        end
      end

      def to_permissions(permissions)
        permissions.map do |permission|
          result = {
            "IpProtocol" => permission.protocol,
            "FromPort" => permission.port_range.first.to_s,
            "ToPort" => permission.port_range.last.to_s,
          }

          if group = permission.groups.first
            begin
              result["SourceSecurityGroupName"] = group.name
            rescue AWS::EC2::Errors::InvalidGroup::NotFound
              result["SourceSecurityGroupId"] = group.id
            end
          end

          result
        end
      end

      def security_groups
        groups = @ec2.security_groups
        if @filter
          groups.filter('group-name', @filter)
        else
          groups
        end
      end

    end
  end
end