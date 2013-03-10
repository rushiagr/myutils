#! /bin/bash
echo "chown stack:stack `readlink /proc/self/fd/*`" >> /root/.bashrc
echo ". /opt/stack/devstack/eucarc" >> /opt/stack/.bashrc
