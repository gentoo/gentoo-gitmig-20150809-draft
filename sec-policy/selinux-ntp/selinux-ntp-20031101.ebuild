# Copyright 1999-2003 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntp/selinux-ntp-20031101.ebuild,v 1.3 2004/06/28 00:10:37 pebenito Exp $

TEFILES="ntpd.te"
FCFILES="ntpd.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for the network time protocol daemon"

KEYWORDS="x86 ppc sparc"

