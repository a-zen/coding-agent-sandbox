FROM ubuntu:resolute-20260627@sha256:b7f48194d4d8b763a478a621cdc81c27be222ba2206ca3ca6bc42b49685f3d9e

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y --no-install-recommends \
        curl git jq nodejs npm python3 ripgrep tmux vim wget zsh \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g context-mode@1.0.169 @anthropic-ai/claude-code@2.1.199

# Renovate tracking for GitHub releases (mise)
# renovate: datasource=github-releases depName=jdx/mise
ENV MISE_VERSION=v2026.7.0
RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/bin/mise MISE_VERSION=$MISE_VERSION sh

RUN curl -fsSL https://antigravity.google/cli/install.sh | bash -s -- -d /usr/bin

USER ubuntu

RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc
RUN ln -s ~/.claude/.claude.json ~/.claude.json

WORKDIR /workdir
