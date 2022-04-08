set -o vi
setxkbmap -option caps:super
# export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
# export XDG_CONFIG_HOME=/home/sourya
# export GNUNET_PREFIX=/usr/local/
# export CPPFLAGS="-I/usr/local/include/gnunet/"
# export LDFLAGS="-L/usr/local/lib/gnunet/"
function unsetproxy
{
unset http_proxy
export http_proxy
unset https_proxy
export https_proxy
unset HTTP_PROXY
export HTTP_PROXY
unset HTTPS_PROXY
export HTTPS_PROXY
}
function gno
{
i3-msg "exec gnome-open $1"
}
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
#"2011-08-14 16:45:05"
function settime 
{
sudo hwclock --set --date "$1"
sudo hwclock --hctosys
}
function sshbtp 
{
sshrc 12CS30035@10.5.18."$1"
}
function fixcaps 
{
    xdotool key Caps_Lock
}
function FIXCAPS 
{
    xdotool key Caps_Lock
}

function opcur
{
i3-msg exec "$1"
}
function setsocks
{
export socks_proxy=socks5://127.0.0.1:9050
export ALL_PROXY=socks5://127.0.0.1:9050
#export socks_proxy=socks://127.0.0.1:9150
#export SOCKS_PROXY=socks://127.0.0.1:9150
export SOCKS_PROXY=socks://127.0.0.1:9050
}
function restartnet
{
sudo service network-manager restart
}

function setproxy
{
export https_proxy=http://10.3.100.207:8080
export http_proxy=http://10.3.100.207:8080
export HTTPS_PROXY=http://10.3.100.207:8080
export HTTP_PROXY=http://10.3.100.207:8080
}

#xmodmap ~/.Xmodmap
# source /usr/share/bash-completion/completions/git
# export https_proxy=http://10.3.100.207:8080
# export http_proxy=http://10.3.100.207:8080
# export HTTPS_PROXY=http://10.3.100.207:8080
# export HTTP_PROXY=http://10.3.100.207:8080
#export PATH=/home/sourya/pro/anaconda2/bin:$PATH
# export PATH=$PATH:~/pro/executable_scripts

#alias youplay="~/pro/executable_scripts/youtube-play.sh"
#alias ssh="sshrc"
#echo "foo"
#eval "$(thefuck --alias)"


# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function ssh_speechrec_vm
{
gcloud compute ssh  --zone "us-central1-c" "sk5057@speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
#gcloud compute ssh --troubleshoot --zone "us-central1-c" "speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
}

function start_speechrec_vm
{
	gcloud compute instances start speech-rec-vm --zone us-central1-c

}

function stop_speechrec_vm
{
	gcloud compute instances stop speech-rec-vm --zone us-central1-c

}

function ssh_dl
{
gcloud compute ssh --zone "us-east1-c" "sk5057@deeplearning-1-vm"  --tunnel-through-iap --project "deep-learning-344607"

#ssh -i ~/.ssh/google_compute_engine sk5057@34.74.72.42

#gcloud compute ssh --zone "us-east1-c" "sk5057@deeplearning-1-vm"  --project "deep-learning-344607"
#gcloud compute ssh --zone "us-east1-c" "sk5057@deeplearning-1-vm"  --project "deep-learning-344607" --troubleshoot
#gcloud compute ssh --zone "us-west1-b" "sk5057@deeplearning-vm-vm"  --project "deep-learning-344607"
}

function ssh_nlp
{
gcloud compute ssh --zone "us-east1-c" "sk5057@nlp-vm"  --project "deep-learning-344607"
}

function start_dl_vm
{
	gcloud compute instances start deeplearning-1-vm --project "deep-learning-344607" --zone "us-east1-c"

}

function stop_dl_vm
{
	gcloud compute instances stop deeplearning-1-vm --project "deep-learning-344607" --zone "us-east1-c"

}


function scp_dl
{
  scp -i  ~/.ssh/google_compute_engine -r $1 sk5057@34.74.72.42:~
}

function vim_bashrc
{
	vim ~/pro/repos/dotfiles/bashrc
}

function cd_spring22
{
	cd ~/pro/columbia/spring22
}


