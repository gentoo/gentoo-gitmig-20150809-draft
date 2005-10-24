# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntp/selinux-ntp-20051023.ebuild,v 1.1 2005/10/24 14:57:14 kaiowas Exp $

inherit selinux-policy

TEFILES="ntpd.te"
FCFILES="ntpd.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for the network time protocol daemon"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

