# 使用官方的Node.js镜像作为基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/liuyi778/node-20-alpine AS builder
# 设置环境变量，存储构建时间（北京时间）
ENV BUILD_TIME=2025-2-9_15:37:39

# 使用 LABEL 指令将构建时间设置为镜像的标签
LABEL build_time="${BUILD_TIME}"
# 更新包列表并安装Git
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories&&apk update&&apk add --no-cache git

# 设置主机DNS
COPY resolv.conf /etc/resolv.conf

# 克隆代码
#WORKDIR /
RUN git clone https://gitee.com/liumou_site/ThriveX-Blog /blog

# 设置工作目录
WORKDIR /blog


# 配置 npm 镜像源
RUN npm config set registry https://registry.npmmirror.com

# 安装依赖
RUN npm install
# 设置环境变量
ENV NEXT_PUBLIC_CACHING_TIME=0
# 设置后端接口地址,http://你的后端域名/api
ENV NEXT_PUBLIC_PROJECT_API="http://server.thrive.site:9003/api"
# 高德地图key
ENV NEXT_PUBLIC_GAODE_KEY_CODE=""
# 高德地图秘钥
ENV NEXT_PUBLIC_GAODE_SECURITYJS_CODE=""