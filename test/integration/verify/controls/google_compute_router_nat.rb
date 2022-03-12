title 'Test GCP google_compute_router_nat resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
router = input('router', value: {
  "name": "inspec-gcp-router",
  "bgp_asn": 64514,
  "bgp_advertise_mode": "CUSTOM",
  "bgp_advertised_group": "ALL_SUBNETS",
  "bgp_advertised_ip_range1": "1.2.3.4",
  "bgp_advertised_ip_range2": "6.7.0.0/16"
}, description: 'Compute router description')
router_nat = input('router_nat', value: {
  "name": "inspec-router-nat",
  "nat_ip_allocate_option": "AUTO_ONLY",
  "source_subnetwork_ip_ranges_to_nat": "ALL_SUBNETWORKS_ALL_IP_RANGES",
  "min_ports_per_vm": 2,
  "log_config_enable": true,
  "log_config_filter": "ERRORS_ONLY"
}, description: 'Compute router NAT description')

control 'google_compute_router_nat-1.0' do
  impact 1.0
  title 'google_compute_router_nat resource test'

  describe google_compute_router_nat(project: gcp_project_id, region: gcp_location, router: router['name'], name: router_nat['name']) do
    it { should exist }
    its('nat_ip_allocate_option') { should cmp router_nat['nat_ip_allocate_option'] }
    its('source_subnetwork_ip_ranges_to_nat') { should cmp router_nat['source_subnetwork_ip_ranges_to_nat'] }
    its('min_ports_per_vm') { should cmp router_nat['min_ports_per_vm'] }
    its('log_config.enable') { should cmp router_nat['log_config_enable'] }
    its('log_config.filter') { should cmp router_nat['log_config_filter'] }
  end

  describe google_compute_router(project: gcp_project_id, region: gcp_location, router: 'nonexistent', name: 'nonexistent') do
    it { should_not exist }
  end
end
