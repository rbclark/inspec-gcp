title 'Test GCP google_compute_subnetwork resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
subnetwork = input('subnetwork', value: {
  "name": "inspec-subnet",
  "ip_cidr_range": "10.2.0.0/16",
  "log_interval": "INTERVAL_10_MIN",
  "log_sampling": 0.5,
  "log_metadata": "INCLUDE_ALL_METADATA"
}, description: 'Compute subnetwork description')

control 'google_compute_subnetwork-1.0' do
  impact 1.0
  title 'google_compute_subnetwork resource test'

  describe google_compute_subnetwork(project: gcp_project_id, region: gcp_location, name: subnetwork['name']) do
    it { should exist }
    its('ip_cidr_range') { should eq subnetwork['ip_cidr_range'] }
    its('log_config.enable') { should be true }
    its('log_config.flow_sampling') { should cmp subnetwork['log_sampling'] }
    its('log_config.aggregation_interval') { should cmp subnetwork['log_interval'] }
    its('log_config.metadata') { should include subnetwork['log_metadata'] }
  end

  describe google_compute_subnetwork(project: gcp_project_id, region: gcp_location, name: 'nonexistent') do
    it { should_not exist }
  end
end
