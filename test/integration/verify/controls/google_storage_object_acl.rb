title 'Test GCP google_storage_object_acl resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_storage_bucket_object = input(:gcp_storage_bucket_object, value: '', description: 'The name of the storage bucket with ACLs attached')
gcp_service_account_display_name = input(:gcp_service_account_display_name, value: '', description: 'The name of the service account assigned permissions')
gcp_enable_privileged_resources = input(:gcp_enable_privileged_resources, value: '', description: 'If we are running tests with escalated permissions(required for this test)')
gcp_storage_bucket_object_name = input(:gcp_storage_bucket_object_name, value: '', description: 'The name of the object with ACLs')
gcp_organization_id = input(:gcp_organization_id, value: '', description: 'The identifier of the organization')

control 'google_storage_object_acl-1.0' do
  impact 1.0
  title 'google_storage_object_acl resource test'

  only_if { gcp_enable_privileged_resources.to_i == 1 && gcp_organization_id != '' }
  describe google_storage_object_acl(bucket: gcp_storage_bucket_object, object: gcp_storage_bucket_object_name, entity: "user-#{gcp_service_account_display_name}@#{gcp_project_id}.iam.gserviceaccount.com") do
    it { should exist }
    its('role') { should cmp "OWNER" }

    its('bucket') { should eq gcp_storage_bucket_object }
    its('email') { should include "#{gcp_service_account_display_name}@#{gcp_project_id}.iam.gserviceaccount.com" }
  end

  describe google_storage_object_acl(bucket: gcp_storage_bucket_object, object: gcp_storage_bucket_object_name, entity: "allUsers") do
    it { should_not exist }
  end
end
