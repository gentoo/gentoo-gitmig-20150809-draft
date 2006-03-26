# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/alg/alg-0.0.1.ebuild,v 1.1 2006/03/26 00:14:08 nattfodd Exp $

DESCRIPTION="Photo management software"
HOMEPAGE="http://www.gna.org/projects/alg"
SRC_URI="http://download.gna.org/alg/alg-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl
		media-libs/sdl-gfx
		media-libs/sdl-image
		media-libs/sdl-ttf"
RDEPEND=""

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
