# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ucspi-tcp/selinux-ucspi-tcp-20031221.ebuild,v 1.2 2004/03/26 21:13:53 aliz Exp $

TEFILES="ucspi-tcp.te"
FCFILES="ucspi-tcp.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for ucspi-tcp"

KEYWORDS="x86 ppc sparc"

