# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-uwimap/selinux-uwimap-2.20110726.ebuild,v 1.1 2011/11/15 10:51:29 swift Exp $
EAPI="4"

IUSE=""
MODS="uwimap"
BASEPOL="2.20110726-r6"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for uwimap"

KEYWORDS="~amd64 ~x86"
