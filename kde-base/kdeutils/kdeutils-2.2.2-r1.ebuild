# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-2.2.2-r1.ebuild,v 1.1 2003/01/17 20:31:29 hannes Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - utilities"
KEYWORDS="x86 ~sparc"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	patch -p1 < ${DISTDIR}/post-${PV}-${PN}.diff
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}
