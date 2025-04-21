# Pega a ultima imagem do Ubuntu em dockerhub. Lasted sera a 24.04 --> https://hub.docker.com/_/ubuntu]
FROM ubuntu:latest
# Atualiza as dependencias do ubuntu e instala o wget
RUN apt-get update \
    && apt-get install -y wget

# Atualiza os pacotes do ubuntu
RUN apt-get update && apt-get upgrade -y

# Download e instala Oracle JDK (Minimo == 20 --> https://www.oracle.com/java/technologies/downloads/)
RUN wget https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.tar.gz \
    && chmod a+x jdk-24_linux-x64_bin.tar.gz \
    && tar -xvf jdk-24_linux-x64_bin.tar.gz \
	&& mv jdk-24.0.1 /opt \
    && rm jdk-24_linux-x64_bin.tar.gz

# Set JAVA_HOME e atualiza PATH
ENV JAVA_HOME=/opt/jdk-24.0.1
ENV PATH=$PATH:$JAVA_HOME/bin

# Java no bashrc
RUN echo 'export JAVA_HOME=/opt/jdk-24.0.1' >> ~/.bashrc \
    && echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# PAcote de Gerenciamento de memoria do Linux (JEMALLOC) --> requisito do BESU
RUN apt install -y libjemalloc-dev
# Faz o download e instala o BESU 25.4.1 (verificado em 20/04/2025)
RUN wget https://github.com/hyperledger/besu/releases/download/25.4.1/besu-25.4.1.tar.gz \
    && chmod a+x besu-25.4.1.tar.gz
RUN tar -xvf besu-25.4.1.tar.gz
RUN rm besu-25.4.1.tar.gz

# Configura BESU PATH
ENV PATH=/besu-25.4.1/bin:$PATH

# Configura o ambiente BESU em bashrc
RUN echo 'export PATH=/besu-25.4.1/bin:$PATH' >> ~/.bashrc

# Cria o ambiente para os 4 Nodes de teste
RUN mkdir -p /besu-25.4.1/QBFT-Network/Node-1/data \
    && mkdir -p /besu-25.4.1/QBFT-Network/Node-2/data \
    && mkdir -p /besu-25.4.1/QBFT-Network/Node-3/data \
    && mkdir -p /besu-25.4.1/QBFT-Network/Node-4/data \
    && mkdir -p /besu-25.4.1/QBFT-Network/Node-5/data \
    && mkdir -p /besu-25.4.1/QBFT-Network/Node-6/data 
# Configura o protocolo de Consenso para o QBFT, copiando o arquivo de genesis de JSON para o diretório de trabalho
COPY qbftConfigFile.json /besu-25.4.1/QBFT-Network
# Defini o diretorio de trabalho, onde os comandos serao executados
WORKDIR /besu-25.4.1/QBFT-Network
# Configura a rede. Ver em https://besu.hyperledger.org/private-networks/tutorials/qbft

RUN besu operator generate-blockchain-config \
    --config-file=qbftConfigFile.json \
    --to=networkFiles \
    --private-key-file-name=key

# O arquivo copy_keys.sh copia as chaves privadas dos 4 nodes para o diretorio de cada node. Essa estrutura eh criada de maneira aleatoria pelo comando acima.
COPY copy_keys.sh /besu-25.4.1/QBFT-Network/
# Retira os line feed do arquivo copy_keys.sh, para que o script funcione corretamente no Linux. O script eh executado no final do Dockerfile.
RUN sed -i 's/\r$//' /besu-25.4.1/QBFT-Network/copy_keys.sh
RUN chmod +x /besu-25.4.1/QBFT-Network/copy_keys.sh
RUN /besu-25.4.1/QBFT-Network/copy_keys.sh
# Instala o JQuery e o Curl, para que o script de inicializacao dos nodes funcione corretamente. O JQuery eh utilizado para fazer o parse do JSON de resposta do node, e o Curl eh utilizado para fazer as requisicoes HTTP para os nodes.
RUN apt install -y jq
RUN apt install -y curl

WORKDIR /besu-25.4.1
COPY n1up.sh n2up.sh n3up.sh n4up.sh n5up.sh n6up.sh /besu-25.4.1/
RUN sed -i 's/\r$//' /besu-25.4.1/n1up.sh
RUN sed -i 's/\r$//' /besu-25.4.1/n2up.sh
RUN sed -i 's/\r$//' /besu-25.4.1/n3up.sh
RUN sed -i 's/\r$//' /besu-25.4.1/n4up.sh
RUN sed -i 's/\r$//' /besu-25.4.1/n5up.sh
RUN sed -i 's/\r$//' /besu-25.4.1/n6up.sh


# Set the entry point to bash
CMD ["/bin/bash"]