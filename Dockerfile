FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python build_gtfs.py && rm -rf output_gtfs/temp_* output_gtfs/mapping

EXPOSE 5000

CMD ["sh", "-c", "gunicorn -w 1 --threads 4 --timeout 60 -b 0.0.0.0:${PORT:-5000} app:app"]