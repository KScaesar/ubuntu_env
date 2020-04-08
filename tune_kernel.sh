#!/bin/bash

# overcommit_memory
echo 'vm.overcommit_memory=1' | sudo tee -a /etc/sysctl.conf

# TCP backlog setting
echo 'net.core.somaxconn=1024' | sudo tee -a /etc/sysctl.conf

# Transparent Huge Pages (THP)
sudo chmod +x /etc/rc.d/rc.local
cat << EOF | sudo tee -a /etc/rc.local
if test -f /sys/kernel/mm/transparent_hugepage/khugepaged/defrag; then
  echo 0 > /sys/kernel/mm/transparent_hugepage/khugepaged/defrag
fi
if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
  echo never > /sys/kernel/mm/transparent_hugepage/defrag
fi
if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
EOF

# reload /etc/sysctl.conf
# https://www.opencli.com/linux/sysctl-read-modify-kernel-var
sudo sysctl -p
