# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

title 'Test GCP google_compute_global_address resource.'

gcp_project_id = input(:gcp_project_id, value: 'gcp_project_id', description: 'The GCP project identifier.')
global_address = input('global_address', value: {
  "name": "inspec-gcp-global-address",
  "ip_version": "IPV6"
}, description: 'Compute Global Address definition')
control 'google_compute_global_address-1.0' do
  impact 1.0
  title 'google_compute_global_address resource test'

  describe google_compute_global_address(project: gcp_project_id, name: global_address['name']) do
    it { should exist }
    its('ip_version') { should eq global_address['ip_version'] }
  end

  describe google_compute_global_address(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
