require_relative '../spec_helper'

describe GeoEngineer::Resources::AwsElasticacheSubnetGroup do
  let(:aws_client) { AwsClients.elasticache }

  before { aws_client.setup_stubbing }

  common_resource_tests(described_class, described_class.type_from_class_name)

  describe "#_fetch_remote_resources" do
    before do
      aws_client.stub_responses(
        :describe_cache_subnet_groups,
        {
          cache_subnet_groups: [
            { cache_subnet_group_name: 'cache-subnet-group-1' },
            { cache_subnet_group_name: 'cache-subnet-group-2' }
          ]
        }
      )
    end

    it 'should create list of hashes from returned AWS SDK' do
      remote_resources = GeoEngineer::Resources::AwsElasticacheSubnetGroup
                         ._fetch_remote_resources(nil)
      expect(remote_resources.length).to eq 2
    end
  end
end
