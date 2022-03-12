title 'GCP KMS Key Ring IAM Binding Properties'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP region being used.')
gcp_kms_key_ring_binding_member_name = input(:gcp_kms_key_ring_binding_member_name, value:'', description: 'GCP key ring name to test against.')
gcp_enable_privileged_resources = input(:gcp_enable_privileged_resources, value: 0, description: 'Flag to enable privileged resources requiring elevated privileges in GCP.')

control 'gcp-kms-key-ring-iam-bindings-1.0' do

  only_if { gcp_enable_privileged_resources.to_i == 1 }
  impact 1.0
  title 'Ensure GCP KMS Key Ring IAM bindings have the correct properties in bulk'

  describe google_kms_key_ring_iam_policy(project: gcp_project_id, location: gcp_location, key_ring_name: gcp_kms_key_ring_binding_member_name) do
    it { should exist }
    its('count') { should be <= 100}
    its('iam_binding_roles') { should include "roles/owner" }
    its('iam_binding_roles') { should include "roles/editor" }
  end
end