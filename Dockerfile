FROM python:3.11-slim

# Ishchi papka
WORKDIR /app

# Sistema paketlari
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Data papkasini yaratish (DB va hashes uchun)
RUN mkdir -p /app/data

# Kutubxonalarni o'rnatish
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Loyiha fayllarini ko'chirish
COPY . .

# Bot ishga tushirish
CMD ["python", "bot.py"]
