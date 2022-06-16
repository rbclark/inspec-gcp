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

title 'Test GCP google_sql_database resource.'

gcp_project_id = input(:gcp_project_id, value: 'gcp_project_id', description: 'The GCP project identifier.')
gcp_db_instance_name = input(:gcp_db_instance_name, value: 'gcp_db_instance_name', description: 'Database instance name.')
gcp_db_name = input(:gcp_db_name, value: 'gcp_db_name', description: 'Database instance name.')

control 'google_sql_database-1.0' do
  impact 1.0
  title 'google_sql_database resource test'

  describe google_sql_database(project: gcp_project_id, instance: gcp_db_instance_name, name: gcp_db_name) do
    it { should exist }
    its('name') { should eq gcp_db_name }
    its('instance') { should eq gcp_db_instance_name }
  end
end
