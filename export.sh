#!/bin/zsh
echo $SHELL
printf "Starting zsh profile export for :"
export WORK_DIR=/home/gotama/Documents/src/github.com/gotama/zsh_shell
export SUB_DIR=/dotfile
export EXPORT_TO=/home/gotama/
printf "\nCopying %s \n%s\n %s" "$WORK_DIR$SUB_DIR" "TO $EXPORT_TO" 
cp -r $WORK_DIR$SUB_DIR/.zshplugins /home/gotama/
cp $WORK_DIR$SUB_DIR/.zshenv /home/gotama/.zshenv
cp $WORK_DIR$SUB_DIR/.zshrc /home/gotama/.zshrc

printf "Source is broken WIP"
#source /home/gotama/.zshrc
exit $ret