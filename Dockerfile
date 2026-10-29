FROM ubuntu:resolute-20261024.1@sha256:6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y --no-install-recommends \
        curl git jq nodejs npm python3 ripgrep tmux vim wget zsh \
    && rm -rf /var/lib/apt/lists/*

RUN node /usr/share/nodejs/npm/bin/npm-cli.js install -g \
    context-mode@1.0.169 \
    @anthropic-ai/claude-code@2.1.287 \
    bmad-method@6.12.0

# Renovate tracking for GitHub releases (mise)
# renovate: datasource=github-releases depName=jdx/mise
ENV MISE_VERSION=v2026.10.3
RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/bin/mise MISE_VERSION=$MISE_VERSION sh

RUN curl -fsSL https://antigravity.google/cli/install.sh | bash -s -- -d /usr/bin

RUN curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/bin sh

USER ubuntu

RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc
RUN ln -s ~/.claude/.claude.json ~/.claude.json

WORKDIR /workdir
