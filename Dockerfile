# Use uma imagem base com Python 3.10
FROM python:3.10-slim

# Defina um diretório de trabalho no contêiner
WORKDIR /app

# Instalar o Poetry (se necessário para o projeto)
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    mv /root/.local/bin/poetry /usr/local/bin/poetry

# Instalar dependências do projeto
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-dev --no-interaction --no-ansi

# Copiar o código do projeto
COPY . /app/

# Definir variáveis de ambiente (se necessário para seu projeto)
ENV POETRY_VIRTUALENVS_CREATE=false

# Instalar o SDK Hyperliquid
RUN pip install hyperliquid-python-sdk

# Expor a porta necessária (se estiver executando um servidor)
EXPOSE 5000

# Defina o comando para rodar o SDK (ou exemplo de uso do SDK)
CMD ["python", "examples/basic_order.py"]
