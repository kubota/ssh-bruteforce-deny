#!/bin/bash

counting_sshconexion(){

  echo "<<< Detecting Brute-Force Attack >>>"

  echo "Invalid > $PARAMETER_01"

  for z in 'grep Invalid /var/log/auth.log | awk '{ print $(NF-2) }' | sort | uniq'
  do

    count1 = 'grep $z /etc/hosts.deny | wc -l'
    count2 = 'grep Invalid /var/log/auth.log | grep $z | wc -l'

    echo "Found $z time #$count2"

    if [ $count1 -eq 0 -a $count2 -gt $PARAMETER_01 ] ; then

      current = 'egrep "^ssh" /etc/hosts.deny | sed 's/sshd[ :,]*//''
      sudo cp /etc/hosts.deny.bak /etc/hosts.deny
      sudo chmod 666 /etc/hosts.deny

      if [ $current ] ; then
        echo "sshd : $current , $z" >> /etc/hosts.deny
        echo "sshd1 : $current , $z"
      else
        echo "sshd : $z" >> /etc/hosts.deny
        echo "sshd2 : $z"
      fi
      sudo chmod 644 /etc/hosts.deny
    fi
  done
}

ssh_blocked(){

  echo "<<< Blocked Failed Connections >>>"

  echo "Failed password > $PARAMETER_02"

  for z in 'grep Failed /var/log/auth.log | grep password | awk '{ print $(NF-3) }' | sort | uniq'
  do

    count1 = 'grep $z /etc/hosts.deny | wc -l'
    count2 = 'grep Failed /var/log/auth.log | grep password |grep $z | wc -l'

    echo "Found $z time #$count2"

    if [ $count1 -eq 0 -a $count2 -gt $PARAMETER_02 ] ; then

      current = 'egrep "^ssh" /etc/hosts.deny | sed 's/sshd[ :,]*//''
      sudo cp /etc/hosts.deny.bak /etc/hosts.deny
      sudo chmod 666 /etc/hosts.deny

      if [ $current ] ; then
        echo "sshd : $current , $z" >> /etc/hosts.deny
        echo "sshd1 : $current , $z"
      else
        echo "sshd : $z" >> /etc/hosts.deny
        echo "sshd2 : $z"
      fi
      sudo chmod 644 /etc/hosts.deny
    fi
  done
}

drop_down(){
  echo "  _ "
  #  echo "_ knock down the target _"
  #  for((loop=1;loop>0;loop+));
  #	do
  #    hping3 -S --flood -V $current
  #	done
}

if [ "$1" == "" ]
then
  echo "                          <<<<< Description >>>>>>>                               "
  echo "./control.bruteforce.ssh.sh [Maximum Brute-Force Attack received] [Block on attack number]"
  echo "Example:  # ./control.bruteforce.ssh.sh 10 100"
else
  echo "<<<<< Protection in Action >>>>>>>"

  PARAMETER_01="$1"
  PARAMETER_02="$2"

  counting_sshconexion
  ssh_blocked

  echo "[*] Listing hosts.deny"
  result = '/bin/cat /etc/hosts.deny'
fi
