
# Dirty workaround related to container issue with gethostbyname not working
# when ip address change.
echo $(hostname -I | cut -d\  -f1) $(hostname) > /etc/hosts
