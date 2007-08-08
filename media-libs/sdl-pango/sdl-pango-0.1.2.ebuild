# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-pango/sdl-pango-0.1.2.ebuild,v 1.4 2007/08/08 19:17:38 vapier Exp $

inherit eutils

DESCRIPTION="connect the text rendering engine of GNOME to SDL"
HOMEPAGE="http://sdlpango.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdlpango/SDL_Pango-${PV}.tar.gz
	http://zarb.org/~gc/t/SDL_Pango-0.1.2-API-adds.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

DEPEND="x11-libs/pango
	media-libs/libsdl"

S=${WORKDIR}/SDL_Pango-${PV}

src_unpack() {
	unpack SDL_Pango-${PV}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/SDL_Pango-0.1.2-API-adds.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
