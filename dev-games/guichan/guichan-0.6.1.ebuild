# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/guichan/guichan-0.6.1.ebuild,v 1.1 2007/03/13 20:12:05 mr_bones_ Exp $

DESCRIPTION="a portable C++ GUI library designed for games using Allegro, SDL and/or OpenGL"
HOMEPAGE="http://guichan.sourceforge.net/"
SRC_URI="mirror://sourceforge/guichan/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="allegro glut opengl sdl"

DEPEND="allegro? ( media-libs/allegro )
	glut? ( virtual/glut )
	opengl? ( virtual/opengl )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-image
	)"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable allegro) \
		$(use_enable glut) \
		$(use_enable opengl) \
		$(use_enable sdl) \
		$(use_enable sdl sdlimage) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
