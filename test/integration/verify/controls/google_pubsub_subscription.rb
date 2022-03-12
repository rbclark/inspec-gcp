title 'Test GCP google_pubsub_subscription resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
subscription = input('subscription', value: {
  "name"=>"inspec-gcp-subscription",
  "ack_deadline_seconds"=>20
})

control 'google_pubsub_subscription-1.0' do
  impact 1.0
  title 'google_pubsub_subscription resource test'

  describe google_pubsub_subscription(project: gcp_project_id, name: subscription['name']) do
    it { should exist }
  end

  describe google_pubsub_subscription(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
