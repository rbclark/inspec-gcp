title 'Test GCP google_sql_flags resource.'

sql_database_flag = input('sql_database_flag', value: {
  "name": "audit_log",
  "type": "STRING",
  "applies_to": "MYSQL_5_6",
  "allowed_string_values": true,
  "requires_restart": true
}, description: 'Database flags for Cloud SQL instances')

control 'google_sql_flags-1.0' do
  impact 1.0
  title 'google_sql_flags resource test'

  describe google_sql_flags do
    its('names') { should include , sql_database_flag['name'] }
    its('types') { should include , sql_database_flag['type'] }
    its('applies_tos.first') { should include , sql_database_flag['applies_to'] }
    its('allowed_string_values.first') { should include , sql_database_flag['allowed_string_values'] }
    its('requires_restarts') { should include , sql_database_flag['requires_restart'] }
  end
end
