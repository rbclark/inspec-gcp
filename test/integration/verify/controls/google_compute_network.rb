title 'Test GCP google_compute_network resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
network = input('network', value: {
  "name": "inspec-network",
  "routing_mode": "REGIONAL"
}, description: 'Network description')

control 'google_compute_network-1.0' do
  impact 1.0
  title 'google_compute_network resource test'

  describe google_compute_network(project: gcp_project_id, name: network['name']) do
    it { should exist }
    its('routing_config.routing_mode') { should cmp network['routing_mode'] }
  end

  describe google_compute_network(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
