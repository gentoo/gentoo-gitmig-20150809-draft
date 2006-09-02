# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/gtklife/gtklife-4.2.ebuild,v 1.2 2006/09/02 07:47:25 mr_bones_ Exp $

inherit games

DESCRIPTION="A Conway's Life simulator for Unix."
HOMEPAGE="http://ironphoenix.org/tril/gtklife/"
SRC_URI="http://ironphoenix.org/tril/gtklife/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/install/s/-s //' \
		-e "/install/s:\$\(.*DIR\):\$(DESTDIR)/&:" \
		-e "/rm/s:\$\(.*DIR\):\$(DESTDIR)/&:" \
		-e "/cp/s:\$\(.*DIR\):\$(DESTDIR)/&:" Makefile \
		|| die "sed failed"
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		PREFIX=/usr \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		DOCDIR="\$(PREFIX)/share/doc/${PF}/html" \
		|| die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		PREFIX=/usr \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		DOCDIR="\$(PREFIX)/share/doc/${PF}/html" \
		install || die "make install failed"
	dodoc ChangeLog NEWS README
	prepgamesdirs
}
