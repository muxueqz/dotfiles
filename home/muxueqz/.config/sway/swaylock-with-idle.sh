sudo id
touch /tmp/last_input_time
sudo sh -c "I3SOCK=$I3SOCK bash /opt/libexec/swayidle.sh" &
swaylock $@

for i in $(seq 10); do
	rm -rfv /tmp/last_input_time
	sleep 1
done

wait
