FROM ubuntu:resolute-20260421@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y --no-install-recommends \
        curl=8.18.* \
        git=1:2.53.* \
        jq=1.8.1-* \
        nodejs=22.22.* \
        npm=9.2.* \
        python3=3.14.* \
        ripgrep=15.1.* \
        tmux=3.6a-* \
        vim=2:9.1.* \
        wget=1.25.* \
        zsh=5.9-* \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g context-mode@1.0.159 @anthropic-ai/claude-code@2.1.153

# Renovate tracking for GitHub releases (mise)
# renovate: datasource=github-releases depName=jdx/mise
ENV MISE_VERSION=v2026.5.0
RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/bin/mise MISE_VERSION=$MISE_VERSION sh

RUN curl -fsSL https://antigravity.google/cli/install.sh | bash -s -- -d /usr/bin

USER ubuntu

RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc
RUN ln -s ~/.claude/.claude.json ~/.claude.json

WORKDIR /workdir
