#!/bin/bash
if [ ! "$1" ];
  then
    # REGULAR HISTORY
    i=0
    for d in /home/* ; do
      username[$i]=$(echo "$d" | sed "s/\/home\///g");
      file_history[$i]=$d"/.bash_history"
      i=$((i+1))
    done
    # ROOT history
    i=0
    for f in /root/.bash_history-*; do
      root_username[$i]=$(echo ${f##*/} | awk -F'-' '{print $2}');
      file_root_history[$i]="/root/"${f##*/};
      i=$((i+1))
    done
    # PROCESSING REGULAR HISTORY
    i=0
    for hist in ${file_history[@]}; do
      cat $hist 2> /dev/null | awk -v username=${username[$i]} -F\# '/^#1[0-9]{9}$/ { if(cmd) printf "%s \033[0;36m(user) \033[0;32m"username"\033[0m\t%s\n",ts,cmd;ts=strftime("%F %T",$2); cmd="";}!/^#1[0-9]{9}$/ { if(cmd)cmd=cmd " " $0; else cmd=$0 }' > .${username[$i]}.htemp
      i=$((i+1))
    done
    # PROCESSING ROOT HISTORY
    i=0
    for hist in ${file_root_history[@]}; do
      cat $hist 2> /dev/null | awk -v username=${root_username[$i]} -F\# '/^#1[0-9]{9}$/ { if(cmd) printf "%s \033[0;31m[SUDO]\033[0m \033[0;32m"username"\033[0m\t%s\n",ts,cmd;ts=strftime("%F %T",$2); cmd="";}!/^#1[0-9]{9}$/ { if(cmd)cmd=cmd " " $0; else cmd=$0 }' > .${username[$i]}-root.htemp
      i=$((i+1))
    done
    find . -type f -name '.*.htemp' -exec cat {} + >> .shtemp
    cat .shtemp | sort -k1
    printf "\n${NC}<<<END: ${GREEN}$(date)${NC}>>>\n"
  else
    printf "\n<<<HISTORY READER>>>\n"
    awk -F\# '/^#1[0-9]{9}$/ { if(cmd) printf "%5d  %s  %s\n",n,ts,cmd;
    ts=strftime("%F %T",$2); cmd=""; n++ }
    !/^#1[0-9]{9}$/ { if(cmd)cmd=cmd " " $0; else cmd=$0 }' $1
fi
# CLEAR TEMPORARY FILES
rm .*htemp
