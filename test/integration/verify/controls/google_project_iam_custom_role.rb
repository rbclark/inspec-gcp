title 'Test GCP google_project_iam_custom_role resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_project_iam_custom_role_id = input(:gcp_project_iam_custom_role_id, value: '', description: 'The IAM custom role identifier.')
gcp_enable_privileged_resources = input(:gcp_enable_privileged_resources, value: 0, description: 'Flag to enable privileged resources requiring elevated privileges in GCP.')
gcp_organization_id = input(:gcp_organization_id, value: '', description: 'The identifier of the organization')

control 'google_project_iam_custom_role-1.0' do
  impact 1.0
  title 'google_project_iam_custom_role resource test'

  only_if { gcp_enable_privileged_resources.to_i == 1 && gcp_organization_id != '' }
  describe google_project_iam_custom_role(project: gcp_project_id, name: gcp_project_iam_custom_role_id) do
    it { should exist }
    its('stage') { should eq 'GA' }
    its('included_permissions') { should eq ["iam.roles.list"] }
  end

  describe google_project_iam_custom_role(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
