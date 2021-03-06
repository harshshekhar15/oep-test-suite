#!/bin/bash

## Env variables

github_username=$1
github_password=$2


## Run Prerequisites
echo -e "\n Running Prerequisites  *********************************************************************\n";

echo -e "\n********* [ Making logs directory ] **********\n";
mkdir -p logs/basic-sanity-tests -v

echo -e "\n**** [ Cloning OEP test-suite directory ] ****\n";
git clone https://$github_username:$github_password@github.com/mayadata-io/oep.git

# Setup litmus on the cluster
echo -e "\n************ [ Setting up Litmus ] ************\n"
kubectl apply -f oep/litmus/prerequisite/rbac.yaml
kubectl apply -f oep/litmus/prerequisite/crds.yaml

# Creating docker secret to be used by litmus jobs 
kubectl apply -f oep/litmus/prerequisite/docker-secret.yml -n litmus

## Run OEP basic sanity checks
echo -e "\n Running OEP Basic Sanity Checks ************************************************************\n";

echo -e "------------------------------------------\n" >> result.txt

# Run maya-io-server check
echo -e "\n********** [ Running maya-io-server check ] **********\n";
chmod 755 ./basic-sanity-tests/maya-io-server-check.sh
./basic-sanity-tests/maya-io-server-check.sh > ./logs/basic-sanity-tests/maya-io-server-check.log &

# Run maya-ui check
echo -e "\n************* [ Running maya-ui check ] **************\n";
chmod 755 ./basic-sanity-tests/maya-ui-check.sh
./basic-sanity-tests/maya-ui-check.sh > ./logs/basic-sanity-tests/maya-ui-check.log &

# Run od-elasticsearch check
echo -e "\n********* [ Running od-elasticsearch check ] *********\n";
chmod 755 ./basic-sanity-tests/od-elasticsearch-check.sh
./basic-sanity-tests/od-elasticsearch-check.sh > ./logs/basic-sanity-tests/od-elasticsearch-check.log &

# Run od-kibana check
echo -e "\n************ [ Running od-kibana check ] *************\n";
chmod 755 ./basic-sanity-tests/od-kibana-check.sh
./basic-sanity-tests/od-kibana-check.sh > ./logs/basic-sanity-tests/od-kibana-check.log &

# Run alertmanager check
echo -e "\n*********** [ Running alertmanager check ] ***********\n";
chmod 755 ./basic-sanity-tests/alertmanager-check.sh
./basic-sanity-tests/alertmanager-check.sh > ./logs/basic-sanity-tests/alertmanager-check.log &

# Run alertstore check
echo -e "\n************ [ Running alertstore check ] ************\n";
chmod 755 ./basic-sanity-tests/alertstore-check.sh
./basic-sanity-tests/alertstore-check.sh > ./logs/basic-sanity-tests/alertstore-check.log &

# Run alertstore-tablemanager check
echo -e "\n****** [ Running alertstore-tablemanager check ] *****\n";
chmod 755 ./basic-sanity-tests/alertstore-tablemanager-check.sh
./basic-sanity-tests/alertstore-tablemanager-check.sh > ./logs/basic-sanity-tests/alertstore-tablemanager-check.log &

# Run cassandra check
echo -e "\n************ [ Running cassandra check ] *************\n";
chmod 755 ./basic-sanity-tests/cassandra-check.sh
./basic-sanity-tests/cassandra-check.sh > ./logs/basic-sanity-tests/cassandra-check.log &

# Run chat-server check
echo -e "\n*********** [ Running chat-server check ] ************\n";
chmod 755 ./basic-sanity-tests/chat-server-check.sh
./basic-sanity-tests/chat-server-check.sh > ./logs/basic-sanity-tests/chat-server-check.log &

# Run cloud-agent check
echo -e "\n*********** [ Running cloud-agent check ] ************\n";
chmod 755 ./basic-sanity-tests/cloud-agent-check.sh
./basic-sanity-tests/cloud-agent-check.sh > ./logs/basic-sanity-tests/cloud-agent-check.log &

# Run configs check
echo -e "\n************* [ Running configs check ] **************\n";
chmod 755 ./basic-sanity-tests/configs-check.sh
./basic-sanity-tests/configs-check.sh > ./logs/basic-sanity-tests/configs-check.log &

# Run configs-db check
echo -e "\n************ [ Running configs-db check ] ************\n";
chmod 755 ./basic-sanity-tests/configs-db-check.sh
./basic-sanity-tests/configs-db-check.sh > ./logs/basic-sanity-tests/configs-db-check.log &

# Run consul check
echo -e "\n************** [ Running consul check ] **************\n";
chmod 755 ./basic-sanity-tests/consul-check.sh
./basic-sanity-tests/consul-check.sh > ./logs/basic-sanity-tests/consul-check.log &

# Run distributor check
echo -e "\n************ [ Running distributor check ] ***********\n";
chmod 755 ./basic-sanity-tests/distributor-check.sh
./basic-sanity-tests/distributor-check.sh > ./logs/basic-sanity-tests/distributor-check.log &

# Run ingester check
echo -e "\n************* [ Running ingester check ] *************\n";
chmod 755 ./basic-sanity-tests/ingester-check.sh
./basic-sanity-tests/ingester-check.sh > ./logs/basic-sanity-tests/ingester-check.log &

# Run ingress-nginx check
echo -e "\n********** [ Running ingress-nginx check ] ***********\n";
chmod 755 ./basic-sanity-tests/ingress-nginx-check.sh
./basic-sanity-tests/ingress-nginx-check.sh > ./logs/basic-sanity-tests/ingress-nginx-check.log &

# Run maya-grafana check
echo -e "\n********** [ Running maya-grafana check ] ************\n";
chmod 755 ./basic-sanity-tests/maya-grafana-check.sh
./basic-sanity-tests/maya-grafana-check.sh > ./logs/basic-sanity-tests/maya-grafana-check.log &

# Run memcached check
echo -e "\n************ [ Running memcached check ] *************\n";
chmod 755 ./basic-sanity-tests/memcached-check.sh
./basic-sanity-tests/memcached-check.sh > ./logs/basic-sanity-tests/memcached-check.log &

# Run mysql check
echo -e "\n************** [ Running mysql check ] ***************\n";
chmod 755 ./basic-sanity-tests/mysql-check.sh
./basic-sanity-tests/mysql-check.sh > ./logs/basic-sanity-tests/mysql-check.log &

# Run querier check
echo -e "\n************* [ Running querier check ] **************\n";
chmod 755 ./basic-sanity-tests/querier-check.sh
./basic-sanity-tests/querier-check.sh > ./logs/basic-sanity-tests/querier-check.log &

# Run ruler check
echo -e "\n************** [ Running ruler check ] ***************\n";
chmod 755 ./basic-sanity-tests/ruler-check.sh
./basic-sanity-tests/ruler-check.sh > ./logs/basic-sanity-tests/ruler-check.log &

wait

echo -e "\n------------------------------------------" >> result.txt

## Run cleanup
echo -e "\n Running Cleanup ***************************************************************************\n";

echo -e "\n************ [ Cleaning up Litmus ] ************\n"
kubectl delete job -n litmus --all;
kubectl delete -f oep/litmus/prerequisite/crds.yaml
kubectl delete -f oep/litmus/prerequisite/rbac.yaml

echo -e "\n*** [ Cleaning up OEP test-suite directory ] ***\n";
rm -rf oep;

## Show results
echo -e "\n Results ***********************************************************************************";
cat result.txt;
echo -e "********************************************************************************************";