# Especificar la versión de Python
ARG PYTHON_VERSION=3.12-slim

FROM python:${PYTHON_VERSION}

# Configuraciones para evitar bytecode y buffer
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Crear directorio de trabajo
RUN mkdir -p /code

# Definir directorio de trabajo
WORKDIR /code

# Copiar el archivo de requisitos
COPY requirements.txt /tmp/requirements.txt

# Instalar dependencias
RUN set -ex && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    rm -rf /root/.cache/

# Copiar el resto del código del proyecto
COPY . /code

# Recopilar archivos estáticos
RUN python manage.py collectstatic --noinput

# Exponer el puerto 8000
EXPOSE 8000

# Comando para iniciar Gunicorn
CMD ["gunicorn", "portfolio_project.wsgi:application", "--bind", "0.0.0.0:8000"]
