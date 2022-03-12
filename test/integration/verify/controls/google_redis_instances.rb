title 'Test GCP google_redis_instances resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
redis = input('redis', value: {
  "name"=>"my-redis-cache",
  "tier"=>"STANDARD_HA",
  "memory_size_gb"=>1,
  "region"=>"us-central1",
  "location_id"=>"us-central1-a",
  "alternative_location_id"=>"us-central1-f",
  "redis_version"=>"REDIS_3_2",
  "display_name"=>"InSpec test instance",
  "reserved_ip_range"=>"192.168.0.0/29", "label_key"=>"key",
  "label_value"=>"value"}
)

control 'google_redis_instances-1.0' do
  impact 1.0
  title 'google_redis_instances resource test'

  describe google_redis_instances(project: gcp_project_id, region: redis['region']) do
    its('tiers') { should include redis['tier'] }
    its('memory_size_gbs') { should include redis['memory_size_gb'] }
    its('alternative_location_ids') { should include redis['alternative_location_id'] }
    its('redis_versions') { should include redis['redis_version'] }
    its('display_names') { should include redis['display_name'] }
    its('reserved_ip_ranges') { should include redis['reserved_ip_range'] }
  end
end
