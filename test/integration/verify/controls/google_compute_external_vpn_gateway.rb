# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
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

title 'Test GCP google_compute_external_vpn_gateway resource.'

gcp_project_id = attribute(:gcp_project_id, default: 'gcp_project_id', description: 'The GCP project identifier.')

external_vpn_gateway = attribute('external_vpn_gateway', default: {
  "name": "external-gateway",
  "redundancy_type": "SINGLE_IP_INTERNALLY_REDUNDANT",
  "description": "An externally managed VPN gateway",
}, description: 'The externally managed vpn gateway.')

control 'google_compute_external_vpn_gateway-1.0' do
  impact 1.0
  title 'google_compute_external_vpn_gateway resource test'

  describe google_compute_external_vpn_gateway(project: gcp_project_id, name: external_vpn_gateway['name']) do
    it { should exist }
  end
end
