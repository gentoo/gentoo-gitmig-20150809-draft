# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vflib/vflib-2.25.6-r1.ebuild,v 1.4 2004/03/19 07:56:05 mr_bones_ Exp $

inherit gcc eutils

IUSE=""

MY_PN="VFlib2"

DESCRIPTION="Japanese Vector Font library"
HOMEPAGE="http://typehack.aial.hiroshima-u.ac.jp/VFlib/"
SRC_URI="ftp://TypeHack.aial.hiroshima-u.ac.jp/pub/TypeHack/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="2"
KEYWORDS="x86 alpha ppc sparc"

DEPEND=">=media-libs/freetype-1.1
	<media-libs/freetype-2
	virtual/x11"
RDEPEND="${DEPEND}
	media-fonts/kochi-substitute"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack () {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	[ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "3" ] \
		&& epatch ${FILESDIR}/${P}-gcc3.diff
}

src_compile () {
	econf --with-freetype \
		--with-freetype-includedir=/usr/include/freetype \
		--with-freetype-libdir=/usr/lib || die

	emake || die
}

src_install () {
	einstall runtimedir=${D}/usr/share/VFlib/${PV} || die

	dodir /usr/share/VFlib/${PV}
	cp -R jTeX ${D}/usr/share/VFlib/${PV}

	dodoc CHANGES COPYING* DISTRIB.txt INSTALL README*
}
