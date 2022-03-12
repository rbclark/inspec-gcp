title 'Test GCP google_compute_ssl_certificates resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
ssl_certificate = input('ssl_certificate', value: {
  "name": "inspec-gcp-ssl-certificate",
  "description": "A fake ssl certificate (DO NOT USE)",
  "certificate": "-----BEGIN CERTIFICATE-----\nMIICqjCCAk+gAwIBAgIJAIuJ+0352Kq4MAoGCCqGSM49BAMCMIGwMQswCQYDVQQG\nEwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjERMA8GA1UEBwwIS2lya2xhbmQxFTAT\nBgNVBAoMDEdvb2dsZSwgSW5jLjEeMBwGA1UECwwVR29vZ2xlIENsb3VkIFBsYXRm\nb3JtMR8wHQYDVQQDDBZ3d3cubXktc2VjdXJlLXNpdGUuY29tMSEwHwYJKoZIhvcN\nAQkBFhJuZWxzb25hQGdvb2dsZS5jb20wHhcNMTcwNjI4MDQ1NjI2WhcNMjcwNjI2\nMDQ1NjI2WjCBsDELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xETAP\nBgNVBAcMCEtpcmtsYW5kMRUwEwYDVQQKDAxHb29nbGUsIEluYy4xHjAcBgNVBAsM\nFUdvb2dsZSBDbG91ZCBQbGF0Zm9ybTEfMB0GA1UEAwwWd3d3Lm15LXNlY3VyZS1z\naXRlLmNvbTEhMB8GCSqGSIb3DQEJARYSbmVsc29uYUBnb29nbGUuY29tMFkwEwYH\nKoZIzj0CAQYIKoZIzj0DAQcDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ\n4mzkzTv0dXyB750fOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwaNQME4wHQYDVR0O\nBBYEFKIQC3A2SDpxcdfn0YLKineDNq/BMB8GA1UdIwQYMBaAFKIQC3A2SDpxcdfn\n0YLKineDNq/BMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhALs4vy+O\nM3jcqgA4fSW/oKw6UJxp+M6a+nGMX+UJR3YgAiEAvvl39QRVAiv84hdoCuyON0lJ\nzqGNhIPGq2ULqXKK8BY=\n-----END CERTIFICATE-----\n",
  "private_key": "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIObtRo8tkUqoMjeHhsOh2ouPpXCgBcP+EDxZCB/tws15oAoGCCqGSM49\nAwEHoUQDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ4mzkzTv0dXyB750f\nOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwQ==\n-----END EC PRIVATE KEY-----\n"
}, description: 'A GCP SSL certificate definition')

control 'google_compute_ssl_certificates-1.0' do
  impact 1.0
  title 'google_compute_ssl_certificates resource test'

  describe google_compute_ssl_certificates(project: gcp_project_id) do
    its('names') { should include ssl_certificate['name'] }
    its('descriptions') { should include ssl_certificate['description'] }
    its('certificates') { should include ssl_certificate['certificate'] }
  end
end
