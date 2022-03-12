title 'Test GCP google_compute_interconnect_locations resource.'

gcp_project_id = input(:gcp_project_id, value: 'gcp_project_id', description: 'The GCP project identifier.')
interconnect_location = input('interconnect_location', value: {
  "name": "akl-zone1-1353",
  "facility_provider_facility_id": "Auckland - Albany",
  "facility_provider": "Vocus"
}, description: 'Retrieves the list of interconnect locations available to the specified project.')

control 'google_compute_interconnect_locations-1.0' do
  impact 1.0
  title 'google_compute_interconnect_locations resource test'

  describe google_compute_interconnect_locations(project: gcp_project_id) do
    its('names') { should include interconnect_location['name'] }
    its('facility_provider_facility_ids') { should include interconnect_location['facility_provider_facility_id'] }
  end
end
