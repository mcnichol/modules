sudo route add -net 10.244.0.0/16    192.168.50.6 # Mac OS X

cf api https://api.bosh-lite.com --skip-ssl-validation
export CF_ADMIN_PASSWORD=$(bosh2 int ./deployment-vars.yml --path /cf_admin_password)
cf auth admin $CF_ADMIN_PASSWORD
