# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-2.2.2-r1.ebuild,v 1.2 2003/02/01 20:18:50 jmorgan Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - SDK: kbabel, ..."
KEYWORDS="x86 sparc"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	patch -p1 < ${DISTDIR}/post-${PV}-${PN}.diff
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}
