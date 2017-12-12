export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET="$(bosh int ./deployments/vbox/creds.yml --path /admin_password)"

git clone https://github.com/cloudfoundry/cf-deployment

cd cf-deployment

bosh -e vbox upload-stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent

bosh -e vbox update-cloud-config iaas-support/bosh-lite/cloud-config.yml

bosh -e vbox -d cf deploy cf-deployment.yml -o operations/bosh-lite.yml --vars-store deployment-vars.yml -v system_domain=bosh-lite.com

bosh -e vbox -d cf instances
