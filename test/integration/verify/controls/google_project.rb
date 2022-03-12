title 'Test GCP google_project resource.'

gcp_project_id = input(:gcp_project_id, value: 'gcp_project_id', description: 'The GCP project identifier.')

control 'google_project-1.0' do
  impact 1.0
  title 'google_project resource test'

  describe google_project(project: gcp_project_id) do
    it { should exist }
    its('project_id') { should cmp gcp_project_id }
    its('lifecycle_state') { should cmp 'ACTIVE' }
  end
end
