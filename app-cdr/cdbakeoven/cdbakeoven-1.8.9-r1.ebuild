# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-1.8.9-r1.ebuild,v 1.11 2004/07/06 12:41:28 carlo Exp $

inherit eutils kde

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
HOMEPAGE="http://cdbakeoven.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbakeoven/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=media-libs/libogg-1.0_rc2
	virtual/mpg123
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11"
RDEPEND=${DEPEND}
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3-gentoo.patch
}
