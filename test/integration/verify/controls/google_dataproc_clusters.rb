title 'Test GCP google_dataproc_clusters resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
gcp_location = input(:gcp_location, value: '', description: 'The GCP project region.')
dataproc_cluster = input('dataproc_cluster', value: {
  "name": "inspec-dataproc-cluster",
  "label_key": "label",
  "label_value": "value",
  "config": {
    "master_config": {
      "num_instances": 1,
      "machine_type": "n1-standard-1",
      "boot_disk_type": "pd-ssd",
      "boot_disk_size_gb": 15
    },
    "worker_config": {
      "num_instances": 2,
      "machine_type": "n1-standard-1",
      "boot_disk_size_gb": 20,
      "num_local_ssds": 1
    },
    "preemptible_worker_config": {
      "num_instances": 0
    },
    "software_config": {
      "prop_key": "dataproc:dataproc.allow.zero.workers",
      "prop_value": "true"
    },
    "gce_cluster_config": {
      "tag": "foo"
    }
  }
}, description: 'Dataproc cluster definition')

control 'google_dataproc_clusters-1.0' do
  impact 1.0
  title 'google_dataproc_clusters resource test'

  describe google_dataproc_clusters(project: gcp_project_id, region: gcp_location) do
    its('count') { should be >= 1 }
    its('cluster_names') { should include dataproc_cluster['name'] }
  end
end
