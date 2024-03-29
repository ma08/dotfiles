set -o vi
setxkbmap -option caps:super
# export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
# export XDG_CONFIG_HOME=/home/sourya
# export GNUNET_PREFIX=/usr/local/
# export CPPFLAGS="-I/usr/local/include/gnunet/"
# export LDFLAGS="-L/usr/local/lib/gnunet/"


alias r='fc -s'
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

function set_brightness_max
{
sudo brightnessctl set 255
}

function set_brightness
{
sudo brightnessctl set $1
}

function set_wall
{
feh --bg-scale ~/Pictures/Wallpapers/buddha_matrix.jpg
}
function ssh_reco
{
ssh sourya@rmeav4.audiovisualreco.com
}
function fuse_vpn_start
{
sudo openvpn --config /home/sourya4/pro/columbia/fuse_summer22/ssl.sourya__ssl_vpn_config.ovpn 
}
function ssh_rubicon_vm
{
cd_fuse && ssh -i rubiconx.pem ubuntu@52.13.250.197
}


function ssh_speechrec_vm
{
gcloud compute ssh --zone "us-east1-c" "speech-rec-ladduu"  --project "fund-speech-rec-proj"
#gcloud compute ssh  --zone "us-central1-c" "sk5057@speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
#gcloud compute ssh --zone "us-central1-c" "sk5057@speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
}

function ssh_speechrec_vm_clone
{
gcloud compute ssh --zone "us-east1-c" "speech-rec-ladduu-$1"  --project "fund-speech-rec-proj"
#gcloud compute ssh  --zone "us-central1-c" "sk5057@speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
#gcloud compute ssh --zone "us-central1-c" "sk5057@speech-rec-vm"  --tunnel-through-iap --project "speech-recognition-341701"
}

function ssh_nlp_ta
{
#gcloud compute ssh --zone "us-east1-c" "nlp-summer-demo-vm"  --project "nlp-summer-358101"
gcloud compute ssh --zone "us-east1-c" "nlp-hw4-tut-vm"  --project "nlp-demo-358110"
#gcloud compute ssh --zone "us-east1-c" "nlp-demo-vm-vm"  --project "nlp-summer-22"
}

function scp_nlp_ta_vm
{
  # scp -i  ~/.ssh/google_compute_engine -r $1 sk5057@34.74.72.42:~
  gcloud compute scp --recurse $1 sourya4@nlp-hw4-tut-vm:~ --project "nlp-demo-358110" --zone us-east1-c
}

function start_speechrec_vm
{
	gcloud compute instances start --zone "us-east1-c" "speech-rec-ladduu"  --project "fund-speech-rec-proj"

}

function start_speechrec_vm_clone
{
  gcloud compute instances start --zone "us-east1-c" "speech-rec-ladduu-$1"  --project "fund-speech-rec-proj"

}
function stop_speechrec_vm_clone
{
  gcloud compute instances stop --zone "us-east1-c" "speech-rec-ladduu-$1"  --project "fund-speech-rec-proj"

}


function stop_speechrec_vm
{
	gcloud compute instances stop  --zone "us-east1-c" "speech-rec-ladduu"  --project "fund-speech-rec-proj"

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

function scp_speech_rec_vm
{
  # scp -i  ~/.ssh/google_compute_engine -r $1 sk5057@34.74.72.42:~
  gcloud compute scp $1 sk5057@speech-rec-vm:~ --project "speech-recognition-341701" --zone us-central1-c
}


#gcloud compute scp sk5057@nlp-hw4-tut-vm:~/nlp_summer22_hw4/GoogleNews-vectors-negative300.bin.gz . --zone "us-east1-c"  --project "nlp-demo-358110"
function scp_nlp_colab
{
  # scp -i  ~/.ssh/google_compute_engine -r $1 sk5057@34.74.72.42:~
  gcloud compute scp $1 sk5057@nlp-colab-1-vm:~ --zone us-east1-c  --tunnel-through-iap --project "deep-learning-344607"
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
function cd_T7
{
	cd /media/sourya4/T7
}

function cd_col
{
	cd ~/pro/columbia_codes/
}

function cd_fuse
{
	cd ~/pro/columbia/fuse_summer22
}

function sox_duration_total
{
  if [[ "$#" -lt 1 ]]; then
    echo "find files!"
    echo "  sox_duration_total *.wav"
    echo ""
    return
  fi

  # for i in "$@"; do
  #   val=`soxi -d "$i"`
  #   echo "$i"
  # done

  #echo -n "$2"

  soxi -D "$@" | python3 -c "import sys;print(\"\ntotal sec:    \" +str( sum(float(l) for l in sys.stdin)))"
  soxi -D "$@" | python3 -c "import sys;print(\"\nmin sec:    \" +str( min(float(l) for l in sys.stdin)))"
  soxi -D "$@" | python3 -c "import sys;print(\"\nmax sec:    \" +str( max(float(l) for l in sys.stdin)))"
  soxi -D "$@" | python3 -c "import sys;print(\"total min:    \" +str( sum(float(l) for l in sys.stdin)/60 ))"
  soxi -D "$@" | python3 -c "import sys;import datetime;print(\"running time: \" +str( datetime.timedelta(seconds=sum(float(l) for l in sys.stdin)) ))"
}

function sox_duration_total_dir
{
    # OUTPUT="$(for i ix *wav; do soxi -D $i; done)";
    # echo "${OUTPUT}"

    ## get total number of seconds of WAVs in dir
    TOTAL_SECS=0
    for i in *wav; do      
        SECS="$(soxi -D $i)"
        echo "$i : $SECS"
        TOTAL_SECS=$(echo "$TOTAL_SECS + $SECS" | bc)
    done
    printf "\n\nThere are a total of ${TOTAL_SECS} seconds of WAV files in the dir\n\n"
}


export PATH="$HOME/pro/repos/JAW/chromedriver:$HOME/bin/greenclip:$PATH"


