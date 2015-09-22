set -o vi
#alias ranger='TERM=xterm-256color ranger'
alias gno="gnome-open"
function mkdirm
{
  command mkdir $1 && cd $1
}
function cdpro
{
  command cd ~/pro
}
function cddisk
{
  command cd /media/sourya/01CE83D74A3EF3D0
}
function cd6thsem
{
  command cd /home/sourya/pro/6thsem
}
function cdOS
{
  command cd /home/sourya/pro/6thsem/OS
}
function gitpush
{
  command git push origin master
}
function gitpull
{
  command git pull origin master
}
function cdNetworks
{
  command cd /home/sourya/pro/6thsem/Networks
}
function cdDBMS
{
  command cd /home/sourya/pro/6thsem/DBMS
}
function cdbtp
{
  command cd /home/sourya/pro/btp/btp-crypto/
}
function cdblog
{
  command cd ~/pro/blogtesting/blog/
}
function torsshchatterbox
{
  command ssh -o ProxyCommand='nc -x 127.0.0.1:9150 %h %p' azureuser@chatterbox2.cloudapp.net
}
function gitstore
{
  git config credential.helper store
}
function yoump3
{
youtube-dl $1 -x --audio-format mp3 --audio-quality 9
}
function settime 
{
sudo hwclock --set --date "$1"
sudo hwclock --hctosys
}

xmodmap ~/.Xmodmap
source /usr/share/bash-completion/completions/git
