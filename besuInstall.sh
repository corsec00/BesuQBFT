#VM: LSI Logic SAS com NVMe. 16G, i7
##################################################
# SSH e VM Tools
##################################################

sudo apt install openssh-server net-tools git open-vm-tools open-vm-tools-desktop
sudo service ssh status
sudo service ssh start
sudo ufw allow ssh
sudo ufw allow http https
# No host local, para limpar o SSH  ssh-keygen -R 10.1.1.128
# Acessar via ssh usuario@ip-do-servidor
# Instalar o VMWare VM Tools (opcional, depende da instalação)

##################################################
# Requisitos 
##################################################

sudo apt update && sudo apt upgrade
#Instalando o Docker
# Pre requisitos
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# GPG Oficial do DOcker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Adicionar repositório do Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Instalar o Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
# Adicionando o usuário ao Grupo Docker
sudo usermod -aG docker $USER
sudo docker run hello-world
# Reiniciar
sudo reboot
# Testar o Docker sem SUDO
docker run hello-world


# Configurando o armazenamento P1
sudo mkdir -p /var/lib/besu
sudo chmod -R 755 /var/lib/besu
# Faucet para o MetaMask
https://www.datawallet.com/crypto/add-megaeth-to-metamask
https://cloud.google.com/application/web3/faucet/ethereum/sepolia

##################################################
# Instalando o Besu com o Docker
##################################################

docker pull hyperledger/besu:latest
docker images
docker stop hello-world
docker rmi -f 74cc54e27dc4
# Executar o Besu em um container
docker run -p 8545:8545 -p 8546:8546 -p 30303:30303 hyperledger/besu:latest --rpc-http-enabled --rpc-ws-enabled  ## Ativo
# Configurando o armazenamento P2
docker run -v /var/lib/besu:/var/lib/besu -p 8545:8545 -p 30303:30303 hyperledger/besu:latest --data-path=/var/lib/besu 
# Personalizando o ambiente na rede TestNet
docker run -p 30303:30303 -p 8545:8545 -e BESU_RPC_HTTP_ENABLED=true -e BESU_NETWORK=sepolia hyperledger/besu:latest
# Rede local: docker run -p 30303:30303 -p 8545:8545 -e BESU_RPC_HTTP_ENABLED=true -e BESU_NETWORK=dev hyperledger/besu:latest
# Rede MainNet: docker run -p 30303:30303 -p 8545:8545 -e BESU_RPC_HTTP_ENABLED=true -e BESU_NETWORK=mainnet hyperledger/besu:latest 
# holesky
# Usando tudo
docker run -v /var/lib/besu:/var/lib/besu -p 8545:8545 -p 30303:30303 -e BESU_RPC_HTTP_ENABLED=true -e BESU_NETWORK=sepolia hyperledger/besu:latest --data-path=/var/lib/besu 


besu --network=sepolia --data-path=/var/lib/besu/nodes/ --sync-mode=SNAP
/var/lib/besu

##################################################
# Instalando o BESU com os binários
##################################################
1 - https://www.youtube.com/watch?v=AWW_Ap84qJc # (Utilizado pela TECBAN e Dinamo Networks - 1:01:05)
2 - https://github.com/alexandregomes3112/Private-BESU-QBFT 

# Instalar o Docker Compose
sudo apt update && sudo apt upgrade -y
# Baixar o Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Deixando o Docker Composer como executável
sudo chmod +x /usr/local/bin/docker-compose
# Validando
docker-compose --version
# Configurando o auto-completar (opcional)
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

# no Docker Desktop WLS no caso de Windows: Settings, Resources, WLS Integration e marcar todos os Ubuntus


# Configurar o BESU
git clone https://github.com/alexandregomes3112/Private-BESU-QBFT.git
cd Private-BESU-QBFT/
# Editar o dockerfile





# Criando os diretórios dos Nodes (pode ser na sua pasta HOME)
sudo mkdir -p RedeBesu

sudo mkdir -p RedeBesu/Node-1
sudo mkdir -p RedeBesu/Node-2
sudo mkdir -p RedeBesu/Node-3
sudo mkdir -p RedeBesu/Node-4

sudo mkdir -p RedeBesu/Node-1/data
sudo mkdir -p RedeBesu/Node-2/data
sudo mkdir -p RedeBesu/Node-3/data
sudo mkdir -p RedeBesu/Node-4/data

sudo chmod -R 755 RedeBesu













# Instalando o Prometheus
docker pull prom/prometheus
docker run -p 9090:9090 prom/prometheus ## Ativo
# Configurar o Besu para exportar as métricas para o Prometheus
docker run -p 8545:8545 -p 30303:30303 -p 9545:9545 hyperledger/besu:latest --metrics-enabled --metrics-host=0.0.0.0 --metrics-port=9545
# Instalar o Grafana
docker pull grafana/grafana
docker run -p 3000:3000 grafana/grafana &
# Acesse o Grafana em  http://localhost:3000 com admin:admin
# Adicione o Prometheus como fonte de dados (http://localhost:9090).
# Importe um painel para monitorar o Besu: Você pode usar painéis prontos, como o Besu Overview, que fornece métricas detalhadas sobre o desempenho do nó, estado de sincronização, taxa de importação de blocos, uso de CPU e memória.



  git config --global user.email "corsec00@gmail.com"
  git config --global user.name "Leo Santos"