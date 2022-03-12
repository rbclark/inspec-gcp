title 'Test GCP google_compute_vpn_tunnel resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
vpn_tunnel = input('vpn_tunnel', value: {
  "name": "inspec-vpn-tunnel",
  "peer_ip": "15.0.0.120",
  "shared_secret": "super secret"
}, description: 'Compute VPN tunnel description')

control 'google_compute_vpn_tunnel-1.0' do
  impact 1.0
  title 'google_compute_vpn_tunnel resource test'

  describe google_compute_vpn_tunnel(project: gcp_project_id, region: gcp_location, name: vpn_tunnel['name']) do
    it { should exist }
    its('peer_ip') { should eq vpn_tunnel['peer_ip'] }
  end

  describe google_compute_vpn_tunnel(project: gcp_project_id, region: gcp_location, name: 'nonexistent') do
    it { should_not exist }
  end
end
