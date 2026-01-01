FROM mcr.microsoft.com/devcontainers/base:ubuntu
RUN apt-get update && apt-get install -y git-lfs fish jq ripgrep && \
    rm -rf /var/lib/apt/lists/*
USER vscode
COPY aliases /home/vscode/.config/aliases
RUN \
    mkdir -p ~/.config/fish && \
    cat /home/vscode/.config/aliases >> ~/.zshrc && \
    cat /home/vscode/.config/aliases >> ~/.bashrc && \
    cat /home/vscode/.config/aliases >> ~/.config/fish/config.fish && \
    curl https://mise.run | sh && \
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc && \
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc && \
    echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish && \
    ~/.local/bin/mise use -g opencode fd fzf bun node uv gh lazygit

USER root
