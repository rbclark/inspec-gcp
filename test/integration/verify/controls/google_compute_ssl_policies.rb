title 'Test GCP google_compute_ssl_policies resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
ssl_policy = input('ssl_policy', value: {
  "name": "inspec-gcp-ssl-policy",
  "min_tls_version": "TLS_1_2",
  "profile": "CUSTOM",
  "custom_feature": "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
  "custom_feature2": "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
})

control 'google_compute_ssl_policies-1.0' do
  impact 1.0
  title 'google_compute_ssl_policies resource test'

  describe google_compute_ssl_policies(project: gcp_project_id) do
    it { should exist }
    its('names') { should include ssl_policy['name'] }
    its('profiles') { should include ssl_policy['profile'] }
    its('count') { should eq 1 }
  end

  google_compute_ssl_policies(project: gcp_project_id).names.each do |policy_name|
    describe google_compute_ssl_policy(project: gcp_project_id, name: policy_name) do
      its('min_tls_version') { should eq ssl_policy['min_tls_version'] }
    end
  end
end
