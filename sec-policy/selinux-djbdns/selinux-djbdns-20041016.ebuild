# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-djbdns/selinux-djbdns-20041016.ebuild,v 1.2 2004/10/28 09:17:26 kaiowas Exp $

inherit selinux-policy

TEFILES="djbdns.te"
FCFILES="djbdns.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp
		sec-policy/selinux-daemontools
		sec-policy/selinux-ucspi-tcp"

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS="x86 ppc sparc amd64"

