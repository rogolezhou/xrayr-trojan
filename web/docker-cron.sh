#!/usr/bin/env bash

set -euxo pipefail

CLOUDFLARE_EMAIL=${CLOUDFLARE_EMAIL}
CLOUDFLARE_API_KEY=${CLOUDFLARE_API_KEY}
# 使用环境变量
lego --email "${CLOUDFLARE_EMAIL}" --dns cloudflare --domains "${WILDCARD_DOMAIN}" --domains "${DOMAIN}" --accept-tos run

# 添加续期任务到 crontab
echo "0 6 1 * * lego --email "${CLOUDFLARE_EMAIL}" --dns cloudflare --domains "${WILDCARD_DOMAIN}" --domains "${DOMAIN}" --accept-tos renew" | crontab -

exec crond -n
