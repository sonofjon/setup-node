## Install Node Version Manager

# nvm (script)
#   Version number is hard coded!

# NVM_PROFILE="$HOME/.bashrc_local"

# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | PROFILE=$NVM_PROFILE bash   # TODO: generalize to latest version

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvm (manual)
#   Uses the latest version!

NVM_PROFILE="$HOME/.bashrc_local"

export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  # shellcheck disable=SC2006,SC2046
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

SOURCE_STR="\\nexport NVM_DIR=\"${PROFILE_INSTALL_DIR}\"\\n[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"  # This loads nvm\\n"
# shellcheck disable=SC2016
COMPLETION_STR='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion\n'

if ! command grep -qc '/nvm.sh' "$NVM_PROFILE"; then
    nvm_echo "=> Appending nvm and bash_completion source strings to $NVM_PROFILE"
    command printf "${SOURCE_STR}" >> "$NVM_PROFILE"
    command printf "$COMPLETION_STR" >> "$NVM_PROFILE"
else
    nvm_echo "=> nvm source string already in ${NVM_PROFILE}"
fi

## Install Node

# Install Node
nvm install --lts

# Upgrade npm on current Node version
nvm install-latest-npm

# npm completion
source <(npm completion)

## Install packages

# Install language servers
npm install -g @ansible/ansible-language-server
npm install -g bash-language-server
npm install -g pyright
npm install -g typescript-language-server typescript
npm install -g yaml-language-server
npm install -g vscode-langservers-extracted   # css, html, js, json, markdown

# Install code linters
#   js, html, ccs: ?
npm install -g eslint   # also included in vscode-langservers-extracted
