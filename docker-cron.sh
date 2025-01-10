#!/usr/bin/env bash

set -euxo pipefail

# 使用环境变量
lego --email "$CLOUDFLARE_EMAIL" --dns cloudflare --domains "$DOMAIN" run

# 添加续期任务到 crontab
echo "0 0 * * * lego --email \"$CLOUDFLARE_EMAIL\" --dns cloudflare --domains \"$DOMAIN\" renew" | crontab -

exec crond -n
