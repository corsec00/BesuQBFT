#!/bin/bash

# Define o caminho principal para as pastas com as chaves.
directory="/besu-25.4.1/QBFT-Network/networkFiles/keys"

# Verifica se o caminho realmente existe
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Inicializa um array vazio para receber o nome das pastas com valores dinâmicos
folders=()

# Faz a iteração na pasta e busca os nomes de todas elas
for folder in "$directory"/*/; do
    # Extrai o nome da pasta
    folder_name=$(basename "$folder")

    # Armazena o nome da pasta no array "folders"
    folders+=("$folder_name")
done

# Faz a iteração com o nome das pastas e copia os pares de chaves para cada uma das pastas dos nós
for index in "${!folders[@]}"; do
        let "n_index = index +1"
        folder="${folders[index]}"
        cp -r "$directory/$folder"/* "/besu-25.4.1/QBFT-Network/Node-$n_index/data/"
done

#Copia o arquivo Genesis para a pasta correta
cp /besu-25.4.1/QBFT-Network/networkFiles/genesis.json /besu-25.4.1/QBFT-Network/