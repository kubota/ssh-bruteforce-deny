# ssh-bruteforce-deny
Detect brute force attacks via failed logins or invalid ones with hosts.deny
<br>
<br>
<br> Note that some distribuitions will show different auth.log outputs, so before running the script, please validate the control command
<br>
<br>In a Azure machine I use:
<br><i>grep Invalid /var/log/auth.log | awk '{ print $(NF-2) }'</i>
<br> However in my ubuntu box, I use:
<br> <i>grep Invalid /var/log/auth.log | awk '{ print $NF }' </i>
<br> 
<br> Also important to take in account is that the auth.log must be in rotation, otherwise you might be blocked if you fail the password more than 100 times :) -> be carefull 
<br>
