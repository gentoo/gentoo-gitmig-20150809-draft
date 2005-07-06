# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/guichan/guichan-0.4.0.ebuild,v 1.2 2005/07/06 07:29:41 dholm Exp $

DESCRIPTION="a portable C++ GUI library designed for games using Allegro, SDL and/or OpenGL"
HOMEPAGE="http://guichan.sourceforge.net/"
SRC_URI="mirror://sourceforge/guichan/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="sdl opengl allegro"

DEPEND="opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl media-libs/sdl-image )
	allegro? ( media-libs/allegro )"

src_compile() {
	econf \
		$(use_enable allegro) \
		$(use_enable sdl) \
		$(use_enable sdl sdlimage) \
		$(use_enable opengl) \
		|| die "Configuration failed"
	emake || die "Build failed"
}
src_install() {
	make install DESTDIR="${D}" || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
