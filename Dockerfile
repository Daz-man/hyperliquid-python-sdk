# Use uma imagem base com Python 3.10
FROM python:3.10-slim

# Defina um diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo poetry.lock e pyproject.toml para o contêiner
COPY pyproject.toml poetry.lock /app/

# Instalar o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    mv /root/.local/bin/poetry /usr/local/bin/poetry

# Garantir que o poetry esteja instalado corretamente
RUN poetry --version

# Instalar as dependências do projeto usando Poetry
RUN poetry install --no-dev --no-interaction --no-ansi

# Copie os arquivos restantes do projeto
COPY . /app/

# Defina a variável de ambiente para permitir a execução sem o virtualenv
ENV POETRY_VIRTUALENVS_CREATE=false

# Exponha a porta em que a aplicação estará rodando (ajuste conforme nec
