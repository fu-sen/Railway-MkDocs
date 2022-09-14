FROM python:3-slim as mkdocs
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdocs build
FROM caddy:alpine
COPY --from=mkdocs ./site/ /usr/share/caddy/
RUN sed -i 's/:80/:{$PORT}/' /etc/caddy/Caddyfile
