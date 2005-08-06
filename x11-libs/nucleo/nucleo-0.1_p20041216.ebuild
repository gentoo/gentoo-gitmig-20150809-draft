# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/nucleo/nucleo-0.1_p20041216.ebuild,v 1.4 2005/08/06 16:45:37 swegener Exp $

inherit eutils

IUSE=""

DESCRIPTION="Nucleo is some library for metisse"
SRC_URI="http://insitu.lri.fr/~chapuis/software/metisse/${P/_p/-}.tar.bz2"
HOMEPAGE="http://insitu.lri.fr/~chapuis/metisse"

DEPEND="virtual/x11
	virtual/opengl
	media-libs/freetype
	media-libs/libpng
	media-libs/jpeg"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc"

S="${WORKDIR}/${P/_p*/}"

src_unpack() {
	unpack ${A}
	cd "${S}"/nucleo/gl/texture
	epatch "${FILESDIR}"/${P/_p*/}-nv.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog AUTHORS NEWS
}
