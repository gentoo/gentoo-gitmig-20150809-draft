# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-munin/selinux-munin-20070329.ebuild,v 1.2 2007/07/11 02:56:47 mr_bones_ Exp $

MODS="munin"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for munin"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

POLICY_PATCH="${FILESDIR}/${P}.patch"
