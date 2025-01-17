# syntax=docker/dockerfile:1

FROM alpine:latest

# 安装必要的工具
RUN apk add --no-cache bash curl && rm -rf /var/cache/apk/*

# 从其他镜像复制可执行文件
COPY --from=mikefarah/yq:latest /usr/bin/yq /usr/bin/yq
COPY --from=ghcr.io/xrayr-project/xrayr:v0.8.3 /usr/local/bin/XrayR /usr/bin/xrayr

# 创建必要的目录
RUN mkdir -p /etc/xrayr/conf.d /etc/xrayr/node.d /tmp/xrayr

# 复制配置文件和入口点脚本
COPY ./config /etc/xrayr
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# 设置卷
VOLUME ["/tmp/xrayr"]

# 设置入口点和命令
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["xrayr", "-config", "/tmp/xrayr/config.yaml"]
