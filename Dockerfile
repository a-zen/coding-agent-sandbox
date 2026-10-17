FROM ubuntu:resolute-20261006@sha256:c098726dd9b9733f3e885f8de0ef375206a311b0a317eadc40d347b1115fb944

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
