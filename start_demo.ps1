# Define a política de execução apenas para a sessão atual do PowerShell
# Remove a mensagem: "Não é possível carregar o módulo de PSReadline"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Create a local docker subnet
Start-Job -ScriptBlock {
    docker network create --subnet=10.10.0.0/24 rede_besu
}
## Cria a rede rede_besu com o IP definido para cada nó de acordo com o besu:fiaptdc. Quando terminar, o container eh removido (--rm) e o container eh iniciado em modo interativo (-it) com o bash (/bin/bash). 
# O --privileged eh usado para permitir acesso total ao host. O -p eh usado para mapear as portas do host para as portas do container. 
# O --hostname eh usado para definir o nome do host do container. O --network eh usado para conectar o container a rede_besu. O --ip eh usado para definir o IP do container na rede_besu.
# Start Node1
Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8545:8545 -p 30303:30303 --rm -it --name Node1 --hostname Node1 --network=rede_besu --ip=10.10.0.11 besu:fiaptdc /bin/bash "
Start-Sleep -Milliseconds 500

# Start Node2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8546:8546 -p 30304:30304 --rm -it --name Node2 --hostname Node2 --network=rede_besu --ip=10.10.0.12 besu:fiaptdc /bin/bash"
Start-Sleep -Milliseconds 500

# Start Node3
Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8547:8547 -p 30305:30305 --rm -it --name Node3 --hostname Node3 --network=rede_besu --ip=10.10.0.13 besu:fiaptdc /bin/bash"
Start-Sleep -Milliseconds 500

# Start Node4
Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8548:8548 -p 30306:30306 --rm -it --name Node4 --hostname Node4 --network=rede_besu --ip=10.10.0.14 besu:fiaptdc /bin/bash "
Start-Sleep -Milliseconds 500

# Start Node5
# Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8549:8549 -p 30307:30307 --rm -it --name Node5 --hostname Node5 --network=rede_besu --ip=10.10.0.15 besu:fiaptdc /bin/bash "
# Start-Sleep -Milliseconds 500

# Start Node6
# Start-Process powershell -ArgumentList "-NoExit", "-Command", "docker run --privileged -p 8550:8550 -p 30308:30308 --rm -it --name Node6 --hostname Node6 --network=rede_besu --ip=10.10.0.16 besu:fiaptdc /bin/bash "
# Start-Sleep -Milliseconds 500
