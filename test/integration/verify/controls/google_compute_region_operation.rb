title 'Test GCP google_compute_region_operation resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
region_operation = input('region_operation', value: {
  "name": "operation-1641188435323-5d4a6f5b26934-9281422c-dce238f5",
  "region": "us-central1",
  "operation_type": "compute.instanceGroupManagers.insert",
  "status": "DONE",
  "progress": 100
}, description: 'Operation resources contained within the specified region')

control 'google_compute_region_operation-1.0' do
  impact 1.0
  title 'google_compute_region_operation resource test'

  describe google_compute_region_operation(project: gcp_project_id, region: region_operation['region'], name: region_operation['name']) do
  it { should exist }
  its('name') { should eq region_operation['name'] }
  its('status') { should eq region_operation['status'] }
  its('progress') { should eq region_operation['progress'] }
  end

  describe google_compute_region_operation(project: gcp_project_id, region: region_operation['region'], name: 'nonexistent') do
  it { should_not exist }
  end
end
