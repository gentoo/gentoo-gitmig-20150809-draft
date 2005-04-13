# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.12-r1.ebuild,v 1.2 2005/04/13 23:59:04 mr_bones_ Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="https://savannah.nongnu.org/projects/crack-attack/"
SRC_URI="http://savannah.nongnu.org/download/crack-attack/${P}-r1.tar.gz
	mirror://debian/pool/main/c/crack-attack/${PN}_${PV}-r1-2.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc sparc x86"
IUSE="gtk"

DEPEND="virtual/glut
	gtk? ( >=x11-libs/gtk+-2.4 )"

S=${WORKDIR}/${P}-r1

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${WORKDIR}"/${PN}_${PV}-r1-2.diff
		"${FILESDIR}"/${P}-garbage.patch
	sed -i \
		-e '/handle flashing/d' src/LevelLights.cxx \
		|| die "sed failed"
}

src_compile() {
	append-flags -DGL_GLEXT_LEGACY
	egamesconf $(use_enable gtk) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -A xpm doc/*
	doicon crack-attack-1.1.12-r1/debian/crack-attack.xpm
	make_desktop_entry crack-attack Crack-attack crack-attack.xpm
	prepgamesdirs
}
