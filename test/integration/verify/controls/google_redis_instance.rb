title 'Test GCP google_redis_instance resource.'

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
  "reserved_ip_range"=>"192.168.0.0/29",
  "label_key"=>"key",
  "label_value"=>"value"
})

control 'google_redis_instance-1.0' do
  impact 1.0
  title 'google_redis_instance resource test'

  describe google_redis_instance(project: gcp_project_id, region: redis['region'], name: redis['name']) do
    it { should exist }
    its('tier') { should cmp redis['tier'] }
    its('memory_size_gb') { should cmp redis['memory_size_gb'] }
    its('alternative_location_id') { should cmp redis['alternative_location_id'] }
    its('redis_version') { should cmp redis['redis_version'] }
    its('display_name') { should cmp redis['display_name'] }
    its('reserved_ip_range') { should cmp redis['reserved_ip_range'] }
    its('labels') { should include(redis['label_key'] => redis['label_value']) }
  end

  describe google_redis_instance(project: gcp_project_id, region: redis['region'], name: 'nonexistent') do
    it { should_not exist }
  end
end
