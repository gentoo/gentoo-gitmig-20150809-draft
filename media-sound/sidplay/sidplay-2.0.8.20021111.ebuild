# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sidplay/sidplay-2.0.8.20021111.ebuild,v 1.3 2003/09/10 22:36:25 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="C64 SID player"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="http://www-ti.informatik.uni-tuebingen.de/~bwurst/${P}.tar.bz2"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=media-sound/libsidutils-1.0.2
	>=media-libs/libsidplay-2.0.8
	>=media-libs/resid-0.13-r1
	>=media-libs/resid-builder-1.6"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL
}
