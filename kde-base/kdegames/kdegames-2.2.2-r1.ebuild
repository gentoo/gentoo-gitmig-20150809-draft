# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-2.2.2-r1.ebuild,v 1.3 2003/02/12 16:48:19 hannes Exp $
inherit kde-dist eutils

IUSE=""
DESCRIPTION="KDE $PV - games"

KEYWORDS="x86 sparc "
SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/post-${PV}-${PN}.diff
}
