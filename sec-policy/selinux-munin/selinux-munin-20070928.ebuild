# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-munin/selinux-munin-20070928.ebuild,v 1.1 2007/11/27 02:45:19 pebenito Exp $

MODS="munin"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for munin"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

POLICY_PATCH="${FILESDIR}/${P}.patch"
