# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dante/selinux-dante-20050201.ebuild,v 1.2 2005/02/06 17:16:35 kaiowas Exp $

inherit selinux-policy

TEFILES="dante.te"
FCFILES="dante.fc"
IUSE=""

DESCRIPTION="SELinux policy for dante (free socks4,5 and msproxy implementation)"

KEYWORDS="x86 ppc sparc amd64"

