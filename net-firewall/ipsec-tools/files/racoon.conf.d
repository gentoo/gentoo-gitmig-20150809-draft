# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/files/racoon.conf.d,v 1.1 2003/12/16 18:04:33 plasmaroo Exp $

# Config file for /etc/init.d/racoon

# see man pages for racoon or run `racoon --help`
# for valid cmdline options
RACOON_OPTS="-4"

RACOON_CONF="/etc/racoon/racoon.conf"
RACOON_PSK_FILE="/etc/racoon/psk.txt"
SETKEY_CONF="/etc/ipsec.conf"
