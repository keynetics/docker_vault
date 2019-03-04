backend "consul" {
  	address = "consul:8500"
  	advertise_addr = "https://vault:8200"
  	scheme = "http"
}
listener "tcp" {
  	address = "0.0.0.0:8200"
    tls_cert_file = "/config/vault.crt"
    tls_key_file = "/config/vault.key"
}
disable_mlock = true
