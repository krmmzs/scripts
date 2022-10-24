echo -e "\\e[1mOS:"
uname -ro
echo
echo -e "\\e[1mUptime:"
uptime -p | sed 's/^up //'
echo
echo -e "\\e[1mHostname:"
uname -n
echo
echo -e "\\e[1mDisk usage:\\e[0m"
df -l -h | grep -E 'dev/nvme0n1p2'
echo
echo -e "\\e[1mNetwork:\\e[0m"
# http://tdt.rocks/linux_network_interface_naming.html
ip addr show up scope global | \
    grep -E ': <|inet' | \
    sed \
    -e 's/^[[:digit:]]\+: //' \
    -e 's/: <.*//' \
    -e 's/.*inet[[:digit:]]* //' \
    -e 's/\/.*//'
