# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/alg/alg-0.0.1.ebuild,v 1.2 2006/03/26 15:57:49 nattfodd Exp $

DESCRIPTION="Photo management software"
HOMEPAGE="http://home.gna.org/alg"
SRC_URI="http://download.gna.org/alg/alg-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl
		media-libs/sdl-gfx
		media-libs/sdl-image
		media-libs/sdl-ttf"


src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
