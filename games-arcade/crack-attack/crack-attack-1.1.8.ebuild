# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.8.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games flag-o-matic eutils
append-flags -DGL_GLEXT_LEGACY

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="http://aluminumangel.org/attack/"
SRC_URI="http://aluminumangel.org/cgi-bin/download_counter.cgi?attack_linux+attack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/glut"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	sed -i 's:-O6:@CXXFLAGS@:' src/Makefile.in
}

src_compile() {
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README AUTHORS ChangeLog
	dohtml -A xpm doc/*
	prepgamesdirs
}
