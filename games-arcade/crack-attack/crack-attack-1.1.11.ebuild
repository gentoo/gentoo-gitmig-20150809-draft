# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.11.ebuild,v 1.1 2004/11/01 09:52:56 mr_bones_ Exp $

inherit eutils flag-o-matic gcc games

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="https://savannah.nongnu.org/projects/crack-attack/"
SRC_URI="http://savannah.nongnu.org/download/crack-attack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"
IUSE="gtk"

DEPEND="virtual/glut
	gtk? ( >=x11-libs/gtk+-2.4 )"

src_compile() {
	append-flags -DGL_GLEXT_LEGACY
	[ "$(gcc-fullversion)" == "3.2.3" ] && filter-flags -march=pentium3
	egamesconf $(use_enable gtk) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -A xpm doc/*
	prepgamesdirs
}
