# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-squid/selinux-squid-20040106.ebuild,v 1.4 2004/09/20 01:55:47 pebenito Exp $

TEFILES="squid.te"
FCFILES="squid.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for squid"

KEYWORDS="x86 ppc sparc amd64"

