#!/bin/sh

ansible $1 -m apt -a "name=ssmtp state=present" --become
ansible $1 -m apt -a "name=mailutils state=present" --become
ansible $1 -m apt -a "name=bsd-mailx state=present" --become
ansible $1 -m apt -a "name=openvpn state=present" --become
ansible $1 -m apt -a "name=telnet state=present" --become
ansible $1 -m apt -a "name=iputils-ping state=present" --become  

ansible $1 -a "mkdir /home/dinky/bin"
ansible $1 -m copy -a "src=./daily_report.sh dest=/home/dinky/bin/"
ansible $1 -m copy -a "src=./firewall.sh dest=/home/dinky/bin/"	
ansible $1 -m copy -a "src=./docker_remove_all.sh dest=/home/dinky/bin/"
ansible $1 -m copy -a "src=./find.sh dest=/home/dinky/bin/"
ansible $1 -m copy -a "src=./rsync_html.sh dest=/home/dinky/bin/"
ansible $1 -m copy -a "src=./sed.sh dest=/home/dinky/bin/"
ansible $1 -m shell -a 'chmod +x /home/dinky/bin/*' --become


ansible $1 -m apt -a "name=docker.io state=present" --become 
ansible $1 -m shell -a 'systemctl enable --now docker' --become
ansible $1 -m shell -a 'usermod -aG docker dinky' --become
ansible $1 -m shell -a 'usermod -aG sudo dinky' --become
ansible $1 -m shell -a 'curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose' --become
ansible $1 -m shell -a "chmod +x /usr/local/bin/docker-compose" --become

#ansible $1 -m copy -a "src=./revaliases dest=/etc/ssmtp/" --become
#ansible $1 -m copy -a "src=./ssmtp.conf dest=/etc/ssmtp/" --become

