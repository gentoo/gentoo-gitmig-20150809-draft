# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-2.2.2-r1.ebuild,v 1.5 2003/07/16 16:22:12 pvdabeel Exp $
inherit kde-dist eutils

IUSE=""
DESCRIPTION="KDE $PV - games"

KEYWORDS="x86 sparc ppc"
SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/post-${PV}-${PN}.diff
}
