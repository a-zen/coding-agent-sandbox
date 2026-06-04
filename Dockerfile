FROM ubuntu:resolute-20260421

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y vim zsh tmux git nodejs npm python3 wget curl jq ripgrep \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/bin/mise sh

RUN curl -fsSL https://antigravity.google/cli/install.sh | CUSTOM_DIR=/usr/bin bash && mv /root/.local/bin/agy /usr/bin

RUN curl -fsSL https://claude.ai/install.sh | bash && mv /root/.local/bin/claude /usr/bin

RUN npm install -g context-mode

USER ubuntu
