# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/files/hostapd-0.4.4-conf.d,v 1.1 2005/08/22 12:51:11 brix Exp $

# List of interfaces which needs to be started before hostapd
INTERFACES="wlan0"

# List of configuration files
CONFIGS="/etc/hostapd/hostapd.conf"

# Extra options to pass to hostapd
OPTIONS="-B"
