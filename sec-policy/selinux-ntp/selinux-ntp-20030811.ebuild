# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntp/selinux-ntp-20030811.ebuild,v 1.1 2003/08/12 02:25:48 pebenito Exp $

TEFILES="ntpd.te"
FCFILES="ntpd.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for the network time protocol daemon"

KEYWORDS="x86"

