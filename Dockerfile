# استخدم نسخة مستقرة (مهم جدًا)
FROM python:3.11-slim

# تحسين سلوك بايثون
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# تثبيت أدوات أساسية (بدون تضخيم الصورة)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# مجلد العمل
WORKDIR /app

# نسخ المتطلبات أولًا للاستفادة من الكاش
COPY requirements.txt .

# تحديث pip وتثبيت dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# نسخ المشروع
COPY . .

# Render يعتمد هذا البورت
EXPOSE 10000

# تشغيل المشروع (بما أن عندك main.py)
CMD ["python", "main.py"]
