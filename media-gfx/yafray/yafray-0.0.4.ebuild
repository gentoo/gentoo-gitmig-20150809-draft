# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.4.ebuild,v 1.5 2005/02/18 01:08:28 lu_zero Exp $

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="media-libs/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s-O3 -fomit-frame-pointer -ffast-math${CXXFLAGS}" \
			src/Makefile.am || \
				die "sed src/Makefile.am failed"
}

src_install() {
	einstall            || die
	dodoc AUTHORS       || die "dodoc failed"
	dohtml doc/doc.html || die "dohtml failed"
}
