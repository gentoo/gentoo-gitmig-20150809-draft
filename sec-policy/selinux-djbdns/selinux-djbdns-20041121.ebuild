# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-djbdns/selinux-djbdns-20041121.ebuild,v 1.2 2004/11/23 17:07:15 kaiowas Exp $

inherit selinux-policy

TEFILES="djbdns.te"
FCFILES="djbdns.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp
		sec-policy/selinux-daemontools"

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS="x86 ppc sparc amd64"

