# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dante/selinux-dante-20041113.ebuild,v 1.1 2004/11/14 20:50:14 kaiowas Exp $

inherit selinux-policy

TEFILES="dante.te"
FCFILES="dante.fc"
IUSE=""

DESCRIPTION="SELinux policy for dante (free socks4,5 and msproxy implementation)"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

