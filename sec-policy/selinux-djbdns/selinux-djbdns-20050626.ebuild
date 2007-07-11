# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-djbdns/selinux-djbdns-20050626.ebuild,v 1.3 2007/07/11 02:56:47 mr_bones_ Exp $

inherit selinux-policy

TEFILES="djbdns.te"
FCFILES="djbdns.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp
		sec-policy/selinux-daemontools
		>=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for djbdns"

KEYWORDS="x86 ppc sparc amd64"
