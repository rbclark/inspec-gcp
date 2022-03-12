title 'Test GCP google_spanner_instance resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
spannerinstance = input('spannerinstance', value: {
  "config": "regional-us-east1",
  "name": "spinstance",
  "display_name": "inspectest",
  "num_nodes": 1,
  "label_key": "env",
  "label_value": "test"
}, description: 'Cloud Spanner definition') 

control 'google_spanner_instance-1.0' do
  impact 1.0
  title 'google_spanner_instance resource test'

  describe google_spanner_instance(project: gcp_project_id, name: spannerinstance['name'], config: spannerinstance['config']) do
    it { should exist }
    its('config') { should match spannerinstance['config'] }
    its('name') { should match spannerinstance['name'] }
    its('display_name') { should eq spannerinstance['display_name'] }
    its('node_count') { should eq spannerinstance['num_nodes'] }
    its('labels') { should include(spannerinstance['label_key'] => spannerinstance['label_value']) }
  end
end
