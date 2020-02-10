#!/bin/bash

## Env variables

github_username=$1
github_password=$2


## Run Prerequisites
echo -e "\n Running Prerequisites  *********************************************************************\n";

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
chmod 755 ./maya-io-server-check.sh
./maya-io-server-check.sh > maya-io-server-check.log &

# Run maya-ui check
echo -e "\n************* [ Running maya-ui check ] **************\n";
chmod 755 ./maya-ui-check.sh
./maya-ui-check.sh > maya-ui-check.log &

# Run od-elasticsearch check
echo -e "\n********* [ Running od-elasticsearch check ] *********\n";
chmod 755 ./od-elasticsearch-check.sh
./od-elasticsearch-check.sh > od-elasticsearch-check.log &

# Run od-kibana check
echo -e "\n************ [ Running od-kibana check ] *************\n";
chmod 755 ./od-kibana-check.sh
./od-kibana-check.sh > od-kibana-check.log &

# Run alertmanager check
echo -e "\n*********** [ Running alertmanager check ] ***********\n";
chmod 755 ./alertmanager-check.sh
./alertmanager-check.sh > alertmanager-check.log &

# Run alertstore check
echo -e "\n************ [ Running alertstore check ] ************\n";
chmod 755 ./alertstore-check.sh
./alertstore-check.sh > alertstore-check.log &

# Run alertstore-tablemanager check
echo -e "\n****** [ Running alertstore-tablemanager check ] *****\n";
chmod 755 ./alertstore-tablemanager-check.sh
./alertstore-tablemanager-check.sh > alertstore-tablemanager-check.log &

# Run cassandra check
echo -e "\n************ [ Running cassandra check ] *************\n";
chmod 755 ./cassandra-check.sh
./cassandra-check.sh > cassandra-check.log &

# Run chat-server check
echo -e "\n*********** [ Running chat-server check ] ************\n";
chmod 755 ./chat-server-check.sh
./chat-server-check.sh > chat-server-check.log &

# Run cloud-agent check
echo -e "\n*********** [ Running cloud-agent check ] ************\n";
chmod 755 ./cloud-agent-check.sh
./cloud-agent-check.sh > cloud-agent-check.log &

# Run configs check
echo -e "\n************* [ Running configs check ] **************\n";
chmod 755 ./configs-check.sh
./configs-check.sh > configs-check.log &

# Run configs-db check
echo -e "\n************ [ Running configs-db check ] ************\n";
chmod 755 ./configs-db-check.sh
./configs-db-check.sh > configs-db-check.log &

# Run consul check
echo -e "\n************** [ Running consul check ] **************\n";
chmod 755 ./consul-check.sh
./consul-check.sh > consul-check.log &

# Run distributor check
echo -e "\n************ [ Running distributor check ] ***********\n";
chmod 755 ./distributor-check.sh
./distributor-check.sh > distributor-check.log &

# Run ingester check
echo -e "\n************* [ Running ingester check ] *************\n";
chmod 755 ./ingester-check.sh
./ingester-check.sh > ingester-check.log &

# Run ingress-nginx check
echo -e "\n********** [ Running ingress-nginx check ] ***********\n";
chmod 755 ./ingress-nginx-check.sh
./ingress-nginx-check.sh > ingress-nginx-check.log &

# Run maya-grafana check
echo -e "\n********** [ Running maya-grafana check ] ************\n";
chmod 755 ./maya-grafana-check.sh
./maya-grafana-check.sh > maya-grafana-check.log &

# Run memcached check
echo -e "\n************ [ Running memcached check ] *************\n";
chmod 755 ./memcached-check.sh
./memcached-check.sh > memcached-check.log &

# Run mysql check
echo -e "\n************** [ Running mysql check ] ***************\n";
chmod 755 ./mysql-check.sh
./mysql-check.sh > mysql-check.log &

# Run querier check
echo -e "\n************* [ Running querier check ] **************\n";
chmod 755 ./querier-check.sh
./querier-check.sh > querier-check.log &

# Run ruler check
echo -e "\n************** [ Running ruler check ] ***************\n";
chmod 755 ./ruler-check.sh
./ruler-check.sh > ruler-check.log &

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