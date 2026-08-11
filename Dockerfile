# Build da aplicação
FROM ubuntu:22.04 AS build-env

# Instala as dependências necessárias do sistema
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Baixa e instala o Flutter SDK
RUN git clone https://github.com -b stable /opt/flutter
ENV PATH="$PATH:/opt/flutter/bin"

# Executa o doctor para garantir que tudo está certo e pré-baixar binários
RUN flutter doctor -v

# Copia os arquivos do projeto para o container
COPY . .

# Obtém as dependências do Flutter e faz o build para Web
RUN flutter pub get
RUN flutter build web

# Estágio 2: Servidor Web para disponibilizar a aplicação
FROM nginx:alpine

# Copia os arquivos buildados do estágio anterior para o Nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expõe a porta 80
EXPOSE 80

# Inicia o Nginx
CMD ["nginx", "-g", "daemon off;"]
