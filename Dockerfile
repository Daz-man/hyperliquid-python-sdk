# Use uma imagem base com Python 3.10
FROM python:3.10-slim

# Atualize o repositório e instale o curl
RUN apt-get update && apt-get install -y curl

# Instalar o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Criar um link simbólico para garantir que o Poetry seja acessível globalmente
RUN ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Garantir que o Poetry esteja instalado corretamente
RUN poetry --version

# Defina um diretório de trabalho no contêiner
WORKDIR /app

# Copiar os arquivos de dependências
COPY pyproject.toml poetry.lock /app/

# Instalar dependências do projeto com o Poetry
RUN poetry install --no-interaction --no-ansi

# Copiar o código do projeto para o contêiner
COPY . /app/

# Definir variáveis de ambiente para evitar a criação de ambientes virtuais
ENV POETRY_VIRTUALENVS_CREATE=false

# Instalar o SDK Hyperliquid
RUN pip install hyperliquid-python-sdk

# Expor a porta necessária (se estiver executando um servidor)
EXPOSE 5000

# Defina o comando para rodar o SDK ou exemplo de uso do SDK
CMD ["python", "examples/basic_order.py"]
