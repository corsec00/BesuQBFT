#!/bin/bash


BESU_URL="http://10.10.0.11:8545"
response=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' $BESU_URL)
enode_address=$(echo $response | jq -r '.result.enode')

n3_path=/besu-25.4.1/QBFT-Network/Node-3/cfg_n3.toml

echo "# NODE 3 Config File" > $n3_path
echo 'data-path="data"' >> $n3_path
echo "# Chain" >> $n3_path
echo 'genesis-file="../genesis.json"' >> $n3_path
echo -e "\n" >> $n3_path

echo "# RPC" >> $n3_path
echo 'rpc-http-enabled=true' >> $n3_path
echo 'rpc-http-api=["DEBUG","ETH", "ADMIN", "WEB3", "QBFT", "NET", "EEA", "PRIV", "PERM","TXPOOL","PLUGINS","MINER","TRACE"]' >> $n3_path
echo 'rpc-http-cors-origins=["all"]' >> $n3_path
echo 'rpc-http-host="0.0.0.0"' >> $n3_path
echo 'rpc-http-port="8547"' >> $n3_path
echo -e "\n" >> $n3_path

echo '# p2p' >> $n3_path
echo 'p2p-enabled=true' >> $n3_path
echo 'p2p-host="10.10.0.13"' >> $n3_path
echo 'p2p-port="30305"' >> $n3_path
echo 'p2p-interface="0.0.0.0"' >> $n3_path
echo 'nat-method="AUTO"' >> $n3_path
echo -e "\n" >> $n3_path

echo "# Bootnodes" >> $n3_path
echo 'bootnodes=["'$enode_address'"]' >> $n3_path



cd /besu-25.4.1/QBFT-Network/Node-3

besu --config-file=cfg_n3.toml \
--host-allowlist="*" 