# Invalid Connections > 10
numb_invalid=10;
echo "Invalid > $numb_invalid"
for z in `grep Invalid /var/log/auth.log | awk '{ print $(NF-2) }' | sort | uniq`
do
 count1=`grep $z /etc/hosts.deny | wc -l`
 count2=`grep Invalid /var/log/auth.log | grep $z | wc -l`
 echo "Found $z time #$count2"
 if [ $count1 -eq 0 -a $count2 -gt $numb_invalid ] ; then
    current=`egrep "^ssh" /etc/hosts.deny | sed 's/sshd[ :,]*//'`
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

# Failed connections > 100
numb_failed=100;
echo "Failed password > $numb_failed"
for z in `grep Failed /var/log/auth.log | grep password | awk '{ print $(NF-3) }' | sort | uniq`
do
 count1=`grep $z /etc/hosts.deny | wc -l`
 count2=`grep Failed /var/log/auth.log | grep password |grep $z | wc -l`
 echo "Found $z time #$count2"
 if [ $count1 -eq 0 -a $count2 -gt $numb_failed ] ; then
    current=`egrep "^ssh" /etc/hosts.deny | sed 's/sshd[ :,]*//'`
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
echo "Listing hosts.deny"
result=`/bin/cat /etc/hosts.deny`
