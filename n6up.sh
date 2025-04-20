#!/bin/bash


BESU_URL="http://10.10.0.11:8545"
response=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' $BESU_URL)
enode_address=$(echo $response | jq -r '.result.enode')

n4_path=/besu-25.4.1/QBFT-Network/Node-6/cfg_n6.toml

echo "# NODE 6 Config File" > $n6_path
echo 'data-path="data"' >> $n6_path
echo "# Chain" >> $n6_path
echo 'genesis-file="../genesis.json"' >> $n6_path
echo -e "\n" >> $n6_path

echo "# RPC" >> $n6_path
echo 'rpc-http-enabled=true' >> $n6_path
echo 'rpc-http-api=["DEBUG","ETH", "ADMIN", "WEB3", "QBFT", "NET", "EEA", "PRIV", "PERM","TXPOOL","PLUGINS","MINER","TRACE"]' >> $n6_path
echo 'rpc-http-cors-origins=["all"]' >> $n6_path
echo 'rpc-http-host="0.0.0.0"' >> $n6_path
echo 'rpc-http-port="8550"' >> $n6_path
echo -e "\n" >> $n6_path

echo '# p2p' >> $n6_path
echo 'p2p-enabled=true' >> $n6_path
echo 'p2p-host="10.10.0.16"' >> $n6_path
echo 'p2p-port="30308"' >> $n6_path
echo 'p2p-interface="0.0.0.0"' >> $n6_path
echo 'nat-method="AUTO"' >> $n6_path

#Minimo de nodes para consenso
echo 'sync-min-peers=3' >> $n1_path


echo -e "\n" >> $n6_path

echo "# Bootnodes" >> $n6_path
echo 'bootnodes=["'$enode_address'"]' >> $n6_path

cd /besu-25.4.1/QBFT-Network/Node-6


besu --config-file=cfg_n6.toml \
--host-allowlist="*" 