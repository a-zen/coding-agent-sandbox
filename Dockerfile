FROM ubuntu:resolute-20260421@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y vim zsh tmux git nodejs npm python3 wget curl jq ripgrep \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/bin/mise sh

RUN npm install -g context-mode

USER ubuntu

RUN curl -fsSL https://antigravity.google/cli/install.sh | bash
RUN curl -fsSL https://claude.ai/install.sh | bash
RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc
RUN rm ~/.claude.json && ln -s ~/.claude/.claude.json ~/.claude.json

WORKDIR /workdir
