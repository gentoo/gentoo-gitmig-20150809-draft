# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ucspi-tcp/selinux-ucspi-tcp-20031221.ebuild,v 1.5 2004/09/20 01:55:47 pebenito Exp $

TEFILES="ucspi-tcp.te"
FCFILES="ucspi-tcp.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for ucspi-tcp"

KEYWORDS="x86 ppc sparc amd64"

