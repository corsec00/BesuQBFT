# Versão: 1.0
##################################################
# Instalando o BESU com os binários
##################################################
# 1 - https://www.youtube.com/watch?v=AWW_Ap84qJc # (Utilizado pela TECBAN e Dinamo Networks - 1:01:05)
# 2 - https://github.com/alexandregomes3112/Private-BESU-QBFT 

# Instalar o git: https://git-scm.com/download/win
# Instalar o Visual Studio Code: https://code.visualstudio.com/download
# Instalar o Docker Desktop: https://www.docker.com/products/docker-desktop/
# Instalar o WLS (Windows Subsystem for Linux)
wsl --install
wsl --list --online
wsl --install -d Ubuntu-24.04 
wsl --list --verbose
wsl --update
# Se for uma VM - Coloque a virtualização em modo de aninhamento (nested virtualization) na CPU da VM

# Atualizar o Azure CLI
winget install --exact --id Microsoft.AzureCLI

# Fork do Github
git clone https://github.com/corsec00/BesuQBFT.git
cd BesuQBFT

# Constroi a estrutura do Besu
docker build -t besu:fiaptdc .

# Inicie a demo do besu
.\start_demo.ps1
# Em cada um dos nodes, execute o seguinte comando para iniciar o Besu em seus respectivos containers (aguarde gerar o endere;o de enode) :
.\n1up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://7c88a36ff20962757b88fdece745d0875d52943cc13978d78507eb468a0b016d53a04fcdbcaf8ab03f17e7daf234ad1251a4c153a79a2edf15c88efb357b35a7@10.10.0.11:30303
.\n2up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://f997a7ef606c9cef9ddd8345a4b80166363394c617f290f9fb6fec553a370486a06f17c4383f65dd542a024ded1abfdb7fe20c2d60b6fa64c05d2fe5be54c3ab@10.10.0.12:30304
.\n3up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://a46c2edd6afa58f893ac929461702b70db6c7b936801fcb74fb11657ff6fdd9cc9167ccd442fec4c1befabee55baa7cb002794c2147bfe8ed461ec98cf40ded6@10.10.0.13:30305
.\n4up.sh # main | INFO  | DefaultP2PNetwork | Enode URL enode://dac208382fabd4ef8941b0e607a2f705953005563d46104206de220363a7242c0ee5c2e1bec58ff3e39e225e51b0d7d954a6c6537ad1800afb429cafe5f492db@10.10.0.14:30306

#Atualiza tudo com o winget
winget update --accept-package-agreements --accept-source-agreements --all --force --disable-interactivity --nowarn --include-unknown
