title 'Test GCP google_dns_managed_zone resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_dns_zone_name = input(:gcp_dns_zone_name, value: '', description: 'The DNS name of the DNS zone.')
dns_managed_zone = input('dns_managed_zone', value: {
  "name"=>"example-zone",
  "description"=>"example description",
  "dnssec_config_state"=>"on"
})

control 'google_dns_managed_zone-1.0' do
  impact 1.0
  title 'google_dns_managed_zone resource test'

  describe google_dns_managed_zone(project: gcp_project_id, zone: dns_managed_zone['name']) do
    it { should exist }
    its('dns_name') { should cmp gcp_dns_zone_name }

    its('description') { should cmp dns_managed_zone['description'] }
    its('zone_signing_key_algorithm') { should cmp 'rsasha256' }
    its('key_signing_key_algorithm') { should cmp 'rsasha512' }
  end

  describe google_dns_managed_zone(project: gcp_project_id, zone: 'nonexistent') do
    it { should_not exist }
  end
end
