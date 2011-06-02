# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-djbdns/selinux-djbdns-2.20101213.ebuild,v 1.2 2011/06/02 12:18:49 blueness Exp $

MODS="djbdns"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-ucspi-tcp
	sec-policy/selinux-daemontools"

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS="amd64 x86"
