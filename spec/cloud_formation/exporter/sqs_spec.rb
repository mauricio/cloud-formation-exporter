require 'cloud_formation/exporter/sqs'

describe CloudFormation::Exporter::SQS do

  let(:client) { CloudFormation::Exporter::SQS.new }
  let(:sqs) { AWS::SQS.new }
  let(:queue_name) { "test-cfn-queue-#{SecureRandom.uuid}" }
  let(:cfn_name) { "test-cfn-sqs-#{SecureRandom.uuid}" }

  context 'describing queues' do

    it 'should generate a valid SQS cloud formation file' do

      sqs.queues.create("")

    end

  end

end