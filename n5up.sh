#!/bin/bash


BESU_URL="http://10.10.0.11:8545"
response=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' $BESU_URL)
enode_address=$(echo $response | jq -r '.result.enode')

n5_path=/besu-25.4.1/QBFT-Network/Node-5/cfg_n5.toml

echo "# NODE 5 Config File" > $n5_path
echo 'data-path="data"' >> $n5_path
echo "# Chain" >> $n5_path
echo 'genesis-file="../genesis.json"' >> $n5_path
echo -e "\n" >> $n5_path

echo "# RPC" >> $n5_path
echo 'rpc-http-enabled=true' >> $n5_path
# Parametros do Drex: https://besu.hyperledger.org/stable/public-networks/reference/api
echo 'rpc-http-api=["DEBUG","ETH", "ADMIN", "WEB3", "QBFT", "NET", "EEA", "PRIV", "PERM","TXPOOL","PLUGINS","MINER","TRACE"]' >> $n5_path
echo 'rpc-http-cors-origins=["all"]' >> $n5_path
echo 'rpc-http-host="0.0.0.0"' >> $n5_path
echo 'rpc-http-port="8549"' >> $n5_path
echo -e "\n" >> $n5_path

echo '# p2p' >> $n5_path
echo 'p2p-enabled=true' >> $n5_path
echo 'p2p-host="10.10.0.15"' >> $n5_path
echo 'p2p-port="30307"' >> $n5_path
echo 'p2p-interface="0.0.0.0"' >> $n5_path
echo 'nat-method="AUTO"' >> $n5_path

#Minimo de nodes para consenso
echo 'sync-min-peers=3' >> $n5_path

echo -e "\n" >> $n5_path

echo "# Bootnodes" >> $n5_path
echo 'bootnodes=["'$enode_address'"]' >> $n5_path

cd /besu-25.4.1/QBFT-Network/Node-5


besu --config-file=cfg_n5.toml \
--host-allowlist="*" 
