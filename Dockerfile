# Usa la imagen base de la última versión de Python
FROM python:3.12-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala las herramientas de compilación y dependencias necesarias
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libatlas-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copia el archivo requirements.txt al contenedor
COPY requirements_c.txt .

# Actualiza pip e instala las dependencias necesarias desde requirements.txt
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements_c.txt

# Copia el archivo de código Python al contenedor
COPY dash_modelos_PF.py .

# Copia los archivos TXT al contenedor
COPY resultado_part1.txt .
COPY resultado_part2.txt .
COPY resultado_part3.txt .

# Expone el puerto 8050 en el contenedor
EXPOSE 8050

# Ejecuta el script de Python
CMD ["python", "dash_modelos_PF.py"]

