title 'Test GCP google_compute_region_operations resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
region_operation = input('region_operation', value: {
  "name": "operation-1641188435323-5d4a6f5b26934-9281422c-dce238f5",
  "region": "us-central1",
  "operation_type": "compute.instanceGroupManagers.insert",
  "status": "DONE",
  "progress": 100
}, description: 'Operation resources contained within the specified region')

control 'google_compute_region_operations-1.0' do
  impact 1.0
  title 'google_compute_region_operations resource test'

  describe google_compute_region_operations(project: gcp_project_id, region: region_operation['region']) do
  	it { should exist }
  	its('names') { should include region_operation['name'] }
  	its('progresses') { should include region_operation['progress'] }
  end
end
