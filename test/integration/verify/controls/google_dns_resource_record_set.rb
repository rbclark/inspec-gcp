title 'Test GCP google_dns_resource_record_set resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
record_set = input('record_set', value: {
  "name": "backend.my.domain.com.",
  "type": "A",
  "ttl": 300,
  "rrdatas1": "8.8.8.8",
  "rrdatas2": "8.8.4.4"
})
managed_zone = input('managed_zone', value: {
  "name": "inspec-gcp-managed-zone",
  "dns_name": "my.domain.com.",
  "description": "A test DNS zone",
  "label_key": "key",
  "label_value": "value"
})

control 'google_dns_resource_record_set-1.0' do
  impact 1.0
  title 'google_dns_resource_record_set resource test'

  describe google_dns_resource_record_set(project: gcp_project_id, name: record_set['name'], type: record_set['type'], managed_zone: managed_zone['name']) do
    it { should exist }
    its('type') { should eq record_set['type'] }
    its('ttl') { should eq record_set['ttl'] }
    its('target') { should include record_set['rrdatas1'] }
    its('target') { should include record_set['rrdatas2'] }
  end
end
