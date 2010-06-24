# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flatzebra/flatzebra-0.1.5.ebuild,v 1.2 2010/06/24 20:55:18 pacho Exp $

EAPI=2

DESCRIPTION="A generic game engine for 2D double-buffering animation"
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libsdl[video]
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e '/^doc_DATA =/s/^/NOTHANKS/' \
		Makefile.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS TODO
}
