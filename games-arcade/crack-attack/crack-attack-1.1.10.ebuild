# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/crack-attack/crack-attack-1.1.10.ebuild,v 1.6 2004/04/05 05:21:13 vapier Exp $

inherit games flag-o-matic gcc

DESCRIPTION="Addictive OpenGL-based block game"
HOMEPAGE="http://aluminumangel.org/attack/"
SRC_URI="http://aluminumangel.org/cgi-bin/download_counter.cgi?attack_linux+attack/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"
IUSE=""

RDEPEND="media-libs/glut"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:-O6:@CXXFLAGS@:' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
}

src_compile() {
	append-flags -DGL_GLEXT_LEGACY
	[ "`gcc-fullversion`" == "3.2.3" ] && filter-flags -march=pentium3
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	dohtml -A xpm doc/*
	prepgamesdirs
}
