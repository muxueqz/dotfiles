. /etc/profile
. $HOME/.bashrc
source /data/encfs/cfg/173bashrc
source ~/.asdf/asdf.sh

export HISTCONTROL=ignoredups:erasedups
export EDITOR=~/.local/bin/lvim

# export LC_ALL=C
export LC_ALL=en_US.UTF-8
export LC_CTYPE=zh_CN.UTF-8
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
#export XMODIFIERS="@im=ibus"
#export QT_IM_MODULE=ibus
#export GTK_IM_MODULE=ibus
#
# export XMODIFIERS="@im=nimf"
# export QT_IM_MODULE=nimf
# export QT4_IM_MODULE=nimf
# export GTK_IM_MODULE=nimf

export JAVA_HOME=/opt/jre
export PATH=$HOME/.asdf/shims_faster/:$HOME/.dotfiles/$HOME/.local/bin:$HOME/.local/bin/:$PATH:/sbin:/usr/sbin:$HOME/bin:/opt/muxueqz-sh/:/opt/muxueqz-py:$JAVA_HOME/bin:/opt/Palm/novacom/:/home/muxueqz/.nimble/bin/
export PATH=$PATH:/data/work/projects/npm/.bin/:/data/work/project/node/bin/
#export PAGER='vim -R -'
export PAGER='less'
# export PAGER='/usr/share/nvim/runtime/macros/less.sh'
export MANPAGER='vim -u /usr/share/nvim/runtime/macros/less.vim -c "noremap gg :1<CR>" +Man!'
export GOTMPDIR=/tmp/build-tmps/
export CM_LAUNCHER=~/.local/bin/clipmenu-launcher
export CM_OUTPUT_CLIP=true
export ROFI_PASS_BACKEND=wtype

#alias bjovpn='sudo ifconfig eth0 down; sudo pkill dhclient; sudo ifconfig eth0 10.200.4.150 up ;sudo route add default gw 10.200.6.201; cd /media/ext4/update/openvpn/xlqy-vpn/;sudo openvpn --config X100-OpenVPN.ovpn --http-proxy 10.200.2.0 8080 --redirect-gateway;cd -'
alias ls='ls --color=auto'
alias ll='ls -alht'
alias rmdup="find  .  -type f  -exec md5sum {} \;|sort |uniq -d -w 33|awk '{print $2}'|xargs rm -rfv "
alias hz02='sudo modprobe ipw2100;sudo pkill wpa_supplicant ; sudo pkill dhcpcd;  sudo wpa_supplicant -ieth0 -chz02.conf -B && sudo dhcpcd eth0'
alias fzhome='sudo rmmod e100;sudo rmmod ipw2100;sudo modprobe ipw2100;sudo pkill wpa_supplicant ; sudo wpa_supplicant -ieth0 -chz02.conf -B && sudo ifconfig eth0 192.168.1.101/24 && sudo route add default gw 192.168.1.1'
alias gz3g='sudo echo;cd /data/software/android-sdk-linux_x86/platform-tools;sudo ./adb forward tcp:8080 tcp:8080;cd /data/software/update/openvpn/xlqy-vpn/;./VPN-HTTP_Proxy.sh'
alias pysh="ipython -p pysh"
alias s2disk="clean-mem.sh;sudo sync;sleep 1s;sudo s2disk"
alias s2ram="sudo chvt 1;sudo sync;sleep 1s;sudo s2ram"
alias mywiki='firefox -app '\''/home/muxueqz/.mozilla/prism/application.ini'\'' -webapp muxueqz.wiki@prism.app'
alias kvm-wxp='sudo qemu-system-x86_64  /data/vm/windows_works.qcow2 --enable-kvm   -m 1024 -spice port=5900,disable-ticketing -net nic,model=virtio -net user,smb=/data/ -vga qxl  -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent -rtc base=localtime -daemonize'
#alias lo-xp='nohup watch Auto-rdp.sh lo-xp 3389 \"-g 1024x768 -r disk:data=/data/\" &> /dev/null'
alias lo-xp="nohup watch xfreerdp --plugin rdpdr --data disk:data:/data -- --plugin cliprdr -u administrator -p 'muxueqz@sohu.com' 127.1 -n muxueqz &> /dev/null"
alias vm-xp="nohup watch xfreerdp --plugin rdpdr --data disk:data:/data -- --plugin cliprdr -u administrator -p 'muxueqz@sohu.com' 10.5.17.39 -n muxueqz &> /dev/null"
alias vdi-xp="rdesktop -A -T VDI -s 'c:\seamlessrdp\seamlessrdpshell.exe explorer' 10.5.17.82 -u administrator -p muxueqz@sohu.com -r disk:data=/data/ -r sound:local"
alias hg-cm='hg commit -m "`hg st`"'
alias hg-up='cd /data/software/muxueqztools/;hg remove -A 2>/dev/null |grep -v "not removing";hg add .;hg commit -m "`hg st|head -n 10`";hg push'
alias pv-sync='rsync  -avzu --progress /data/work/17173_5m/ root@10.5.17.44:/opt/17173/17173_5m/ --exclude="logs*" --exclude="dict_dump" --exclude="*.swp" --exclude="2011*" --exclude=".hg"'
alias pv-sync-test='rsync  -avzu --progress /data/work/17173_5m/ root@10.5.17.7:/root/work/17173_5m/ --exclude="logs*" --exclude="dict_dump" --exclude="*.swp" --exclude="2011*"'
alias qq-logs-up='sudo modprobe nbd max_part=8;sudo qemu-nbd -r -c /dev/nbd10 /dev/sda5 -n && sleep 1s && sudo ntfs-3g /dev/nbd10 /data/qqlog && /opt/muxueqz-sh/QQ-rsync-bak.sh;sudo umount /data/qqlog/;sudo qemu-nbd -d /dev/nbd10;sudo rmmod nbd'
alias qq-logs-down='sudo modprobe nbd max_part=8;sudo qemu-nbd -c /dev/nbd10 /dev/sda5 && sleep 1s && sudo ntfs-3g /dev/nbd10 /data/qqlog && /opt/muxueqz-sh/QQ-rsync-Down.sh;sudo umount /data/qqlog/;sudo qemu-nbd -d /dev/nbd10;sudo rmmod nbd'

alias es='sudo emerge --sync'
alias eu='sudo emerge -avuDN --keep-going=y world'
alias esu='sudo emerge --sync && sudo emerge -vuDN --keep-going=y world'
alias ec='sudo emerge --depclean'
alias er='sudo revdep-rebuild -- --keep-going=y'
alias ecr='sudo emerge --depclean && sudo revdep-rebuild -- --keep-going=y'
alias eo='sudo emerge --complete-graph=y --oneshot --autounmask=n --keep-going=y'
alias xf86='sudo emerge -avt `qlist -I -C xf86-`'
alias chrome-android="chrome --user-agent='Mozilla/5.0 (Linux; U; Android 0.5; en-us) AppleWebKit/522+ (KHTML, like Gecko ) Safari/419.3'"
alias whois="python /usr/lib/python2.7/site-packages/pywhois-0.1-py2.7.egg/pywhois/whois.py"
alias cnpm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"
alias yarn-cn="yarn --registry=https://registry.npm.taobao.org"
alias muxueqz_full_proxy="sudo su - v2ray -c 'while true;do /home/v2ray/run_proxy.sh;sleep 3s;done'"
# alias muxueqz_light_proxy="sudo su - v2ray -c 'while true;do /home/v2ray/run_light_proxy.sh;sleep 3s;done'"
alias muxueqz_light_proxy="firejail \
  --private=/data/work/project/v2ray-linux-32/ \
  --profile=/data/work/project/firejail-profiles/v2ray.profile \
  ~/v2ray -config ~/v2ray-client-light.json"
alias muxueqz_light_proxy="sh /data/work/project/firejail-profiles/v2ray.sh"
alias muxueqz_light_proxy="sh /data/work/project/firejail-profiles/clash.sh"
alias worklog_day="cd /data/work/project/bespin/bp-auto-worklog/; bash auto_worklog.sh day; cd -"
alias worklog_week="cd /data/work/project/bespin/bp-auto-worklog/; vim auto_worklog.sh && bash auto_worklog.sh week ; cd -"
alias pretty_json='jello'
alias bp_gitclone='git clone -c user.email=mingyuan.zhang@bespinglobal.cn -c user.name=张明源 '
alias weekly-report='python /opt/muxueqz-py/github_weekly.py'
alias switch-edp-dispaly='xrandr --output eDP-1 --auto --mode 1600x900 '

workon() {
	cd ~/workspaces/$1
}

alias vim-notmp='firejail --env=PATH=/data/work/project/x-apps-in-container/vbin/:$PATH \
  --deterministic-shutdown \
  --env=GOTMPDIR=/tmp --noprofile --private-tmp --mkdir=/tmp/nimlsp \
  lvim'
alias vim-no-jail='lvim'
alias vim='vim-notmp'
alias vimdiff='vim -d'
alias vi='vim'
alias docker=podman
alias mvi='mpv --config-dir=$HOME/.config/mpv-image-viewer/'
alias gpicview=mvi

ipydb() {
	export NLS_LANG='SIMPLIFIED CHINESE_CHINA.UTF8'
	export ORACLE_HOME=/data/work/project/oci_12_1/
	export LD_LIBRARY_PATH=$ORACLE_HOME
	/data/work/project/ipydb_venv/bin/ipython --profile=ipydb
}

allmount() {
	sudo echo starting...
	cd /dev
	for s in sd{b,c}{1..13}; do
		[[ -e "$s" ]] &&
			sudo mkdir -p /media/$s &&
			sudo mount $s /media/$s
	done # 1> /dev/null 2>&1
	cd -
}
# alias set_proxy="export http_proxy='http://127.0.0.1:11082' ; export https_proxy=\$http_proxy"
set-proxy() {
	if [[ -z $1 ]]; then
		export http_proxy="http://default-proxy-server:11082"
	else
		export http_proxy="http://${1}"
	fi
	echo $http_proxy
	export https_proxy=$http_proxy
}

alias unset-proxy="unset http_proxy; unset https_proxy"

mksniso() {
	sudo mkisofs -r -T -J -V “bjsn” -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $1 $PWD
}

docker_portmapping() {
	container_name=$1
	src_port=$2
	dst_port=$3

	ip_addr=$(docker inspect ${container_name} | grep '"IPAddress"' | sed 's/"//'g | cut -d':' -f2 | cut -d',' -f1)
	sudo iptables -t nat -A DOCKER -p tcp --dport ${dst_port} -j DNAT --to-destination ${ip_addr}:${src_port}
}

7zcat() {
	#PATH=${GZIP_BINDIR-'/bin'}:$PATH
	exec 7z e -so -bd "$@" 2>/dev/null | cat
}

kvm-temp-vm() {
	sudo qemu-system-x86_64 -enable-kvm -m 512 $1 -snapshot -net nic,model=virtio -net bridge,br=docker0 -cdrom /data/iso/rhel-server-6.4-x86_64-dvd.iso
}

function log2syslog {
	declare command
	command=$(fc -ln -0)
	logger -p local1.notice -t bash -i — $USER : "$command"
}
trap log2syslog DEBUG


steam_start() {
	udisksctl mount --block-device /dev/disk/by-label/usb_data
	# cd /media/muxueqz/usb_data/steam_env/
	# [[ ! -d rootfs/tmp/ ]] && sudo mount -t overlay overlay -olowerdir=/,upperdir=upperdir/,workdir=workdir/ rootfs/
	bash -x /data/work/project/firejail-profiles/steam-in-nspawn.sh
}

steam_stop() {
	cd ~
	sudo umount /media/muxueqz/usb_data/steam_env/rootfs
	udisksctl unmount --block-device /dev/disk/by-label/usb_data
	disk_id=$(readlink /dev/disk/by-label/usb_data | xargs basename | grep -o '[a-z]*')
	udisksctl power-off --block-device /dev/${disk_id}
}

temp-workspaces() {
	mkdir -pv /dev/shm/temp-workspaces/
	cd /dev/shm/temp-workspaces/
}
alias tw=temp-workspaces

source ~/workspaces/powerline-bash/.powerline-bash.sh
source ~/.dotfiles/$HOME/.bash_completion

export PATH=$PATH:/data/work/projects/bash-completion-pinyin.nim/
source /data/work/projects/bash-completion-pinyin.nim/pinyin.completion
