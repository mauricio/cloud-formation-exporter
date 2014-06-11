require 'cloud_formation/exporter/sqs'

describe CloudFormation::Exporter::SQS do

  let(:client) { CloudFormation::Exporter::SQS.new }

  context 'describing queues' do

    it 'should describe all queues' do
      puts client.to_json
    end

  end

end