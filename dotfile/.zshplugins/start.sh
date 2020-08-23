# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
    fpath=($HOME/.zshplugins/$plugin $fpath)
done


# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
    source $HOME/.zshplugins/$plugin.plugin.zsh
done