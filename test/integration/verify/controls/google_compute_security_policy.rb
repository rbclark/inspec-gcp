title 'Test GCP google_compute_security_policy resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
security_policy = input('security_policy', value: {
  "name": "sec-policy",
  "action": "deny(403)",
  "priority": "1000",
  "ip_range": "9.9.9.0/24",
  "description": "my description"
}, description: 'Security Policy description')

control 'google_compute_security_policy-1.0' do
  impact 1.0
  title 'google_compute_security_policy resource test'

  describe google_compute_security_policy(project: gcp_project_id, name: security_policy['name']) do
    it { should exist }
    its('rules.size') { should cmp 2 }
    its('rules.first.priority') { should cmp security_policy['priority'] }
    its('rules.first.match.config.src_ip_ranges.first') { should cmp security_policy['ip_range'] }
  end

  describe google_compute_security_policy(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
