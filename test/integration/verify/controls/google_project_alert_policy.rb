title 'Test GCP google_project_alert_policy resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
alert_policy = input('alert_policy', value: {
  "display_name": "Display",
  "combiner": "OR",
  "condition_display_name": "condition",
  "condition_filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\"",
  "condition_duration": "60s",
  "condition_comparison": "COMPARISON_GT"
}, description: 'Alert Policy description')

control 'google_project_alert_policy-1.0' do
  impact 1.0
  title 'google_project_alert_policy resource test'

  describe.one do
    google_project_alert_policies(project: gcp_project_id).policy_names do |policy_name|
      describe google_project_alert_policy(project: gcp_project_id, name: policy_name) do
        it { should exist }
        its('display_name') { should cmp alert_policy['display_name']}
        its('combiner') { should cmp alert_policy['combiner']}
        it { should be_enabled }
      end
    end
  end
end
