sudo mkdir -p /sys/fs/cgroup/net_cls
sudo mount -t cgroup -o net_cls net_cls /sys/fs/cgroup/net_cls
sudo mkdir /sys/fs/cgroup/net_cls/isolated
echo 0x100001 | sudo tee /sys/fs/cgroup/net_cls/isolated/net_cls.classid
echo "$PID" | sudo tee /sys/fs/cgroup/net_cls/isolated/tasks
sudo iptables -t mangle -A OUTPUT -m cgroup --cgroup 0x100001 -j MARK --set-mark 0x100001
sudo ip route add default via 192.168.101.254 dev eth0 table 100
sudo ip rule add fwmark 0x100001 lookup 100
cat /sys/fs/cgroup/net_cls/isolated/tasks
