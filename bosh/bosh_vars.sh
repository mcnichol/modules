export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`bosh int ./deployments/vbox/creds.yml --path /admin_password`
