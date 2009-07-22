# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-munin/selinux-munin-20070329.ebuild,v 1.3 2009/07/22 13:12:25 pebenito Exp $

MODS="munin"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for munin"

KEYWORDS="~amd64 ~x86"

POLICY_PATCH="${FILESDIR}/${P}.patch"
