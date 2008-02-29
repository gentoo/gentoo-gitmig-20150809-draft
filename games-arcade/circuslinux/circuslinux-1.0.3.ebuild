# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/circuslinux/circuslinux-1.0.3.ebuild,v 1.16 2008/02/29 18:54:41 carlo Exp $

inherit eutils games

DESCRIPTION="clone of the Atari 2600 game \"Circus Atari\""
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/circus-linux/${P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/circus-linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^install-data-am/d" \
		Makefile.in \
		|| die "sed failed"
	sed -i \
		-e 's/\$(pkgdatadir)/$(DESTDIR)&/' \
		data/Makefile.in \
		|| die "sed failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/images/${PN}-icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Circus Linux!" ${PN}
	dodoc *.txt
	prepgamesdirs
}
