# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.6.2.ebuild,v 1.1 2004/04/08 23:27:03 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://liquidwar.sunsite.dk/archive/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND=">media-libs/allegro-4.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:/games::' \
		-e '/^MANDIR/ s:=.*:= $(mandir)/man6:' \
		-e '/^PIXDIR/ s:=.*:= /usr/share/pixmaps:' \
		-e '/^DESKTOPDIR/ s:=.*:= /usr/share/applnk/Games/:' \
		-e '/^INFODIR/ s/=.*/= $(infodir)/' \
		-e '/^GAMEDIR/ s/exec_prefix/bindir/' \
		-e 's:$(DOCDIR)/txt:$(DOCDIR):g' \
		-e 's:$(GMAKE):$(MAKE):' \
		-e '/^DOCDIR/ s:=.*:= /usr/share/doc/$(P):' Makefile.in \
			|| die 'sed Makefile.in failed'
	sed -i \
		-e '/^GAMEDIR/ s/$(exec_prefix)/@bindir@/' \
		-e 's:/games::' src/Makefile.in \
			|| die "sed src/Makefile.in failed"
}

src_compile() {
	# Fixes build problem with gcc3 and -march=pentium4
	replace-flags "-march=pentium4" "-march=pentium3"
	egamesconf --disable-doc-ps --disable-doc-pdf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install_nolink || die "make install failed"
	rm -f "${D}/usr/share/doc/${P}/COPYING"
	use nls || rm -f "${D}/usr/share/doc/${P}/README.*"
	gzip -9 "${D}/usr/share/doc/${P}/"{[A-Z]*,*txt}
	prepgamesdirs
}
