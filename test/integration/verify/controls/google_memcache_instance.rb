title 'Test GCP google_memcache_instance resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
memcache_instance = input('memcache_instance', value: {
  "name": "mem-instance"
}, description: 'Memcache settings')

control 'google_memcache_instance-1.0' do
  impact 1.0
  title 'google_memcache_instance resource test'

  describe google_memcache_instance(project: gcp_project_id, region: gcp_location, name: memcache_instance['name']) do
    it { should exist }
    its('node_count') { should cmp 1 }
  end

  describe google_memcache_instance(project: gcp_project_id, region: gcp_location, name: "nonexistent") do
    it { should_not exist }
  end
end
