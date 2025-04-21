#!/bin/bash


BESU_URL="http://10.10.0.11:8545"
response=$(curl -s -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' $BESU_URL)
enode_address=$(echo $response | jq -r '.result.enode')

n2_path=/besu-25.4.1/QBFT-Network/Node-2/cfg_n2.toml

echo "# NODE 2 Config File" > $n2_path
echo 'data-path="data"' >> $n2_path
echo "# Chain" >> $n2_path
echo 'genesis-file="../genesis.json"' >> $n2_path
echo -e "\n" >> $n2_path

echo "# RPC" >> $n2_path
echo 'rpc-http-enabled=true' >> $n2_path
# Parametros do Drex: https://besu.hyperledger.org/stable/public-networks/reference/api
echo 'rpc-http-api=["DEBUG","ETH", "ADMIN", "WEB3", "QBFT", "NET", "EEA", "PRIV", "PERM","TXPOOL","PLUGINS","MINER","TRACE"]' >> $n2_path
echo 'rpc-http-cors-origins=["all"]' >> $n2_path
echo 'rpc-http-host="0.0.0.0"' >> $n2_path
echo 'rpc-http-port="8546"' >> $n2_path
echo -e "\n" >> $n2_path

echo '# p2p' >> $n2_path
echo 'p2p-enabled=true' >> $n2_path
echo 'p2p-host="10.10.0.12"' >> $n2_path
echo 'p2p-port="30304"' >> $n2_path
echo 'p2p-interface="0.0.0.0"' >> $n2_path
echo 'nat-method="AUTO"' >> $n2_path

#Minimo de nodes para consenso
echo 'sync-min-peers=3' >> $n1_path

echo -e "\n" >> $n2_path

echo "# Bootnodes" >> $n2_path
echo 'bootnodes=["'$enode_address'"]' >> $n2_path

cd /besu-25.4.1/QBFT-Network/Node-2


besu --config-file=cfg_n2.toml \
--host-allowlist="*" 