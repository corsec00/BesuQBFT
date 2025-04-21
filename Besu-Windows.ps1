# Versão: 1.0
##################################################
# Instalando o BESU com os binários
##################################################
# 1 - https://www.youtube.com/watch?v=AWW_Ap84qJc # (Utilizado pela TECBAN e Dinamo Networks - 1:09:05)
# 2 - Instale o Git (https://git-scm.com/download/win)
# 3 - 
# 4 - Instale o Visual Studio Code (https://code.visualstudio.com/download)
# 5 - Habilitar virtualização
$nome_VM = "Besu-win11"
Set-VMProcessor -VMName $nome_VM -ExposeVirtualizationExtensions $true


# 6 - Instale o Windows Subsystem for Linux (WSL) (https://docs.microsoft.com/pt-br/windows/wsl/install)
wsl --install
wsl --list --online
wsl --install -d Ubuntu-24.04 
wsl --list --verbose
wsl --update
wsl --set-default-version 2
# 7 - Instale o Docker Desktop (https://www.docker.com/products/docker-desktop/)

# Se for uma VM - Coloque a virtualização em modo de aninhamento (nested virtualization) na CPU da VM

# 8 - Atualizar o Azure CLI
winget search Microsoft.PowerShell
winget install --id Microsoft.PowerShell.Preview --source winget
winget install --exact --id Microsoft.AzureCLI

# 9 - Fork do Github
git clone https://github.com/corsec00/BesuQBFT.git
set-location BesuQBFT

# Constroi a estrutura do Besu
docker build -t besu:fiaptdc .

# Inicie a demo do besu
.\start_demo.ps1
# Em cada um dos nodes, execute o seguinte comando para iniciar o Besu em seus respectivos containers (aguarde gerar o endere;o de enode) :
.\n1up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://7c88a36ff20962757b88fdece745d0875d52943cc13978d78507eb468a0b016d53a04fcdbcaf8ab03f17e7daf234ad1251a4c153a79a2edf15c88efb357b35a7@10.10.0.11:30303
.\n2up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://f997a7ef606c9cef9ddd8345a4b80166363394c617f290f9fb6fec553a370486a06f17c4383f65dd542a024ded1abfdb7fe20c2d60b6fa64c05d2fe5be54c3ab@10.10.0.12:30304
.\n3up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://a46c2edd6afa58f893ac929461702b70db6c7b936801fcb74fb11657ff6fdd9cc9167ccd442fec4c1befabee55baa7cb002794c2147bfe8ed461ec98cf40ded6@10.10.0.13:30305
.\n4up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://dac208382fabd4ef8941b0e607a2f705953005563d46104206de220363a7242c0ee5c2e1bec58ff3e39e225e51b0d7d954a6c6537ad1800afb429cafe5f492db@10.10.0.14:30306
.\n5up.sh
.\n6up.sh
# Configurar o Chainless --> https://besu.hyperledger.org/private-networks/how-to/monitor/chainlens
git clone https://github.com/web3labs/chainlens-free.git # (dentro do WLS)
cd chainlens-free/docker-compose/
NODE_ENDPOINT=http://10.10.0.11:8545 docker-compose up # (dentro do WLS)
# http://localhost

# Integracao com o Metamask --> https://besu.hyperledger.org/private-networks/how-to/monitor/metamask
# Instale o MetaMask ou acesse a partir do seu navegado https://microsoftedge.microsoft.com/addons/detail/metamask/ejbalbakoplchlghecdalmeeeajnimhm
# Importar as chaves dos Tokens (nao as chaves de infraestrutura) para o Metamask 


#Atualiza tudo com o winget
winget update --accept-package-agreements --accept-source-agreements --all --force --disable-interactivity --nowarn --include-unknown
