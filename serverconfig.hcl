disable_mlock = true
max_lease_ttl = "10h"
default_lease_ttl = "10h"

backend "inmem" {}

listener "tcp" {
 address = "127.0.0.1:8200"
 tls_disable = 1
}
