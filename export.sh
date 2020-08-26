#!/bin/zsh
echo $SHELL
printf "Starting zsh profile export for :"
export SOURCE_DIR=$HOME/Documents/github.com/gotama/zsh_shell
export SUB_DIR=/dotfile
printf "\nCopying %s \n%s\n %s" "$SOURCE_DIR$SUB_DIR" "TO $HOME" 
printf "\n Plugins are disabled.... \n"
rm -rf $HOME/.zshplugins
cp -r $SOURCE_DIR$SUB_DIR/.zshplugins $HOME/
cp $SOURCE_DIR$SUB_DIR/.zshenv $HOME/.zshenv
cp $SOURCE_DIR$SUB_DIR/.zshrc $HOME/.zshrc

printf "Source is broken WIP"
#source /home/gotama/.zshrc
exit $ret