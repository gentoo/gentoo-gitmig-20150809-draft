# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.11-r1.ebuild,v 1.1 2004/12/03 02:46:49 vapier Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="https://savannah.nongnu.org/projects/crack-attack/"
SRC_URI="http://savannah.nongnu.org/download/crack-attack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc sparc x86"
IUSE="gtk"

DEPEND="virtual/glut
	gtk? ( >=x11-libs/gtk+-2.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-multi-compat.patch
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
	prepgamesdirs
}
