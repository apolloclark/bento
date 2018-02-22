#!/bin/sh -eux

# get the REDHAT variables
if [ -z "$REDHAT_USER" ]; then
    echo "ERROR: Missing <REDHAT_USER> env var"
    exit 1
fi

if [ -z "$REDHAT_PASS" ]]; then
    echo "ERROR: Missing <REDHAT_PASS> env var"
    exit 1
fi

# register with Redhat
subscription-manager register --username "$REDHAT_USER" --password "$REDHAT_PASS"

# refresh
subscription-manager refresh

# register with self-serve virtual subscription
subscription-manager subscribe --pool=8a85f98c615810120161582177020497

# upgrade system
yum update -y

# remove subscription
subscription-manager remove --all
subscription-manager unregister
subscription-manager clean

systemctl reboot
