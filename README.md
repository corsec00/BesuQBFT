# BesuQBFT
Instalação de uma rede Hyperledger BESU com 4 nós e com o protocolo Quorum Byzantine Fault Tolerance (QBFT). <br />
Este laboratório tem como base o trabalho de @alexandregomes3112
## Pré Requisitos
✅ Windows 11 <br />
✅ Virtualização habilitada <br />
✅ [Windows Subsystem for Linux](https://docs.microsoft.com/pt-br/windows/wsl/install) (WSL) instalado <br />
    ```wsl --install```<br />
    ```wsl --list --online ```<br />
    ```wsl --install -d Ubuntu-24.04 ```<br />
    ```wsl --list --verbose  ```<br />
    ```wsl --update```<br />

✅ [Git](https://git-scm.com/download/win) e [Visual Studio Code](https://code.visualstudio.com/download) instalados<br />
✅ [Ubunto para WSL](https://apps.microsoft.com/detail/9nz3klhxdjp5?hl=en-US&gl=US) instalado<br />
✅ [Docker e Docker Compose](https://www.docker.com/products/docker-desktop/) instalados<br />
✅ Conta ativada no Github<br />
✅ Instale o [MetaMask](https://microsoftedge.microsoft.com/addons/detail/metamask/ejbalbakoplchlghecdalmeeeajnimhm) ou acesse a partir do seu navegador - Exemplo no Microsoft Edge<br />
✅ Atualizaçao de pacotes do Azure CLI e Terminal <br />
    ```winget install --id Microsoft.PowerShell.Preview --source winget```<br />
    ```winget install --exact --id Microsoft.AzureCLI```<br />

✅ Fork do código no Github<br />
    ```git clone https://github.com/corsec00/BesuQBFT.git```    
## Instalação do Hyperledger BESU
A partir do diretório onde o repositório foi baixado, execute o seguinte comando para construir o HL Besu no Docker.<br />
``` docker build -t besu:fiaptdc .```<br />
Uma vez instalado, use o script ```.\start_demo.ps1``` para subir os nós (1 Ordering Service, 2 nós com o mínimo de 3 peers para um consenso)<p>
Para cada um dos terminais abertos, execute o comando ```.\nxup.sh```, onde x é o número do node:<br />
```.\n1up.sh``` no node-1<br />
```.\n2up.sh``` no node-2<br />
```.\n3up.sh``` no node-3<br />
```.\n4up.sh``` no node-4<br />
## Configurar o Chainless Block Explorer
O [Chainless](https://besu.hyperledger.org/private-networks/how-to/monitor/chainlens) será usado para acompanhar a situação dos blocos e a estrutura das transações do BESU<br />
1. Em um terminal WSL2 rodando **UBUNTU** Clone o repositório da Chainless<br />
```git clone https://github.com/web3labs/chainlens-free```<br />
1. Entre na pasta com os arquivos da Chainless<br />
```cd chainlens-free/docker-compose/```<br />
1. Procure o arquivo `docker-compose.yml` disponível na pasta onde estão os arquivos do BESU e substitua pelo arquivo que está em: `chainlens-free/docker-compose/`<br />
1. Execute o script de inicialização do ambiente da Chainless:<br />
    ```NODE_ENDPOINT=http://10.10.0.11:8545 docker-compose up```
