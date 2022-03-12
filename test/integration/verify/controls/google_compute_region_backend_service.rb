title 'Test GCP google_compute_region_backend_service resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
region_backend_service = input('region_backend_service', value: {
  "name": "inspec-gcp-region-backend-service",
  "description": "A regional description",
  "protocol": "TCP",
  "timeout_sec": 15
}, description: 'Backend service definition')

control 'google_compute_region_backend_service-1.0' do
  impact 1.0
  title 'google_compute_region_backend_service resource test'

  describe google_compute_region_backend_service(project: gcp_project_id, region: gcp_location, name: region_backend_service['name']) do
    it { should exist }
    its('description') { should eq region_backend_service['description'] }
    its('protocol') { should eq region_backend_service['protocol'] }
    its('timeout_sec') { should eq region_backend_service['timeout_sec'] }
  end

  describe google_compute_region_backend_service(project: gcp_project_id, region: gcp_location, name: 'nonexistent') do
    it { should_not exist }
  end
end
