#!/bin/bash


BESU_URL="http://10.10.0.11:8545"
response=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' $BESU_URL)
enode_address=$(echo $response | jq -r '.result.enode')

n4_path=/besu-25.4.1/QBFT-Network/Node-4/cfg_n4.toml

echo "# NODE 3 Config File" > $n4_path
echo 'data-path="data"' >> $n4_path
echo "# Chain" >> $n4_path
echo 'genesis-file="../genesis.json"' >> $n4_path
echo -e "\n" >> $n4_path

echo "# RPC" >> $n4_path
echo 'rpc-http-enabled=true' >> $n4_path
echo 'rpc-http-api=["DEBUG","ETH", "ADMIN", "WEB3", "QBFT", "NET", "EEA", "PRIV", "PERM","TXPOOL","PLUGINS","MINER","TRACE"]' >> $n4_path
echo 'rpc-http-cors-origins=["all"]' >> $n4_path
echo 'rpc-http-host="0.0.0.0"' >> $n4_path
echo 'rpc-http-port="8548"' >> $n4_path
echo -e "\n" >> $n4_path

echo '# p2p' >> $n4_path
echo 'p2p-enabled=true' >> $n4_path
echo 'p2p-host="10.10.0.14"' >> $n4_path
echo 'p2p-port="30306"' >> $n4_path
echo 'p2p-interface="0.0.0.0"' >> $n4_path
echo 'nat-method="AUTO"' >> $n4_path
echo -e "\n" >> $n4_path

echo "# Bootnodes" >> $n4_path
echo 'bootnodes=["'$enode_address'"]' >> $n4_path

cd /besu-25.4.1/QBFT-Network/Node-4


besu --config-file=cfg_n4.toml \
--host-allowlist="*" 