# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/leocad/leocad-20021123.ebuild,v 1.2 2003/02/13 09:04:56 vapier Exp $

DESCRIPTION="LeoCAD is a CAD program that uses bricks similar to those found in many toys"
HOMEPAGE="http://www.leocad.org/"
SRC_URI="http://rugth38.phys.rug.nl/heijs/${P}.tar.bz2
	http://www.leocad.org/files/pieces.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib"

src_compile() {
	cp ${FILESDIR}/leocad ../
	make || die
}

src_install() {
	into /usr
	dobin ../leocad
	insinto /usr/lib/leocad
	doins bin/leocad
	chmod a+x ${D}/usr/lib/leocad/leocad
	cp bin/leocad ${D}/usr/lib/leocad/
	insinto /usr/lib/leocad/lib
	doins ../pieces.* ../textures.*
	doman docs/leocad.1
	dodoc docs/*.txt
}
