# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.5.7.ebuild,v 1.2 2008/01/21 07:36:52 nyhm Exp $

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/openal
	media-libs/freealut
	=dev-libs/libsigc++-1.2*"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin caelum/.libs/caelum || die "dobin failed"
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog NEWS README TODO
}
