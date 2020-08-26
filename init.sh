mkdir ignoredirectory
cd ignoredirectory
# List of third-party repos

# --------
# ZSH SYNTAX HIGHLIGHTER
# --------
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd zsh-syntax-highlighting
mkdir ../../dotfile/.zshplugins/zsh-syntax-highlighting
cp zsh-syntax-highlighting.plugin.zsh ../../dotfile
cp zsh-syntax-highlighting.zsh ../../dotfile/zsh-syntax-highlighting
cp .revision-hash ../../dotfile/zsh-syntax-highlighting/
cp .version ../../dotfile/zsh-syntax-highlighting/
cp -r highlighters ../../dotfile/zsh-syntax-highlighting/

# --------
# ZSH AUTO SUGGESTIONS
# --------
git clone https://github.com/zsh-users/zsh-autosuggestions.git
cd zsh-autosuggestions
mkdir ../../dotfile/.zshplugins/zsh-autosuggestions
cp zsh-autosuggestions.plugin.zsh ../../dotfile/.zshplugins/
cp zsh-autosuggestions.zsh ../../dotfile/.zshplugins/zsh-autosuggestions/