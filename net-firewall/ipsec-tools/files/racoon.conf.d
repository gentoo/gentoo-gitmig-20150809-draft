# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/files/racoon.conf.d,v 1.2 2004/04/12 07:00:30 plasmaroo Exp $

# Config file for /etc/init.d/racoon

# See the manual pages for racoon or run `racoon --help`
# for valid command-line options

RACOON_OPTS="-4"

RACOON_CONF="/etc/racoon/racoon.conf"
RACOON_PSK_FILE="/etc/racoon/psk.txt"
SETKEY_CONF="/etc/ipsec.conf"

# Comment or remove the following if you don't want the policy tables
# to be flushed when racoon is stopped.

RACOON_RESET_TABLES="true"
