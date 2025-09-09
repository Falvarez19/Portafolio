# Dockerfile
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Si tienes requirements.txt en el repo:
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copiá el código
COPY . .

# (Opcional) si usas staticfiles:
# RUN python manage.py collectstatic --noinput || true

# Fly va a hacer healthcheck a este puerto interno
ENV PORT=8000

# IMPORTANTE: ajusta "yourproject" al nombre real del módulo wsgi de tu proyecto
# (ej: si tienes yourproject/wsgi.py -> yourproject.wsgi:application)
CMD ["gunicorn", "yourproject.wsgi:application", "--bind", "0.0.0.0:8000"]
