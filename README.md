# BesuQBFT
Instalação de uma rede Hyperledger BESU com 4 nós
Este laboratório tem como base o trabalho de @alexandregomes3112
## Pré Requisitos
✅ Windows 11
✅ Virtualização habilitada
✅ Windows Subsystem for Linux (WSL) instalado (https://docs.microsoft.com/pt-br/windows/wsl/install)
    ```sh
   wsl --install
   wsl --list --online
   wsl --install -d Ubuntu-24.04 
   wsl --list --verbose
   wsl --update
    ```
✅ Git (https://git-scm.com/download/win) e Visual Studio Code (https://code.visualstudio.com/download) instalados
✅ Ubunto para WSL instalado (https://apps.microsoft.com/detail/9nz3klhxdjp5?hl=en-US&gl=US)
✅ Docker e Docker Compose (https://www.docker.com/products/docker-desktop/) instalados
✅ Conta ativada no Github
✅ Atualizaçao de pacotes do Azure CLI e Terminal 
    ```sh
    winget install --id Microsoft.PowerShell.Preview --source winget
    winget install --exact --id Microsoft.AzureCLI
    ```
✅ Fork do código no Github
    ```sh
    git clone https://github.com/corsec00/BesuQBFT.git
    ```    