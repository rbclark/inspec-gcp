title 'Test GCP google_runtime_config_configs resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
runtimeconfig_config = input('runtimeconfig_config', value: {
  "name"=>"inspec-gcp-runtime-config",
  "description"=>"My runtime configurations"}
)

control 'google_runtime_config_configs-1.0' do
  impact 1.0
  title 'google_runtime_config_configs resource test'

  describe google_runtime_config_configs(project: gcp_project_id) do
    its('descriptions') { should include runtimeconfig_config['description'] }
  end
end
