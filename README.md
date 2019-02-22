# bash-history-tracker
Extended Bash History
This is a simple script to expand the fuctionality of the bash history. Just place it in /usr/local/bin/ with +x permissons.
 
#### Turn On Color Prompt for root.
```
sed 's/#force_color_prompt/force_color_prompt/g' -i /root/.bashrc
```
#### Human-friendly history for new-users.
```
echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/skel/.bashrc
```
#### Human-friendly history for root.
```
echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /root/.bashrc
```
#### Detection of privilege elevation in history.
```
echo 'HISTFILE=/root/.bash_history-$SUDO_USER' >> /root/.bashrc
```
#### Looks something like this:
```
2019-02-12 11:59:39 (user) user1	sudo -i
2019-02-12 12:00:05 [SUDO] user1	cd /tmp/
2019-02-12 12:12:30 [SUDO] user1	nano ssl.conf
2019-02-12 12:12:34 [SUDO] user1	openssl req -new -key server.key -out server.csr -config ssl.conf
2019-02-12 12:14:08 [SUDO] user1	rm ssl.conf
2019-02-12 19:01:48 (user) user2	sudo -i
2019-02-12 19:01:52 [SUDO] user2	get_pool.sh pool=AZUREGOS
2019-02-13 13:22:34 [SUDO] user2	get_pool.sh > pools_$date.txt
2019-02-13 13:28:16 [SUDO] user2	cat pools_.txt
2019-02-13 13:28:57 [SUDO] user2	mutt
2019-02-13 13:29:14 [SUDO] user2	mail
```
