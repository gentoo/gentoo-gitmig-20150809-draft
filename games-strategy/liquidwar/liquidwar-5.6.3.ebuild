# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.6.3.ebuild,v 1.5 2006/08/15 09:11:02 corsair Exp $

inherit flag-o-matic games

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://savannah.nongnu.org/download/liquidwar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE="nls"
RESTRICT="test"

DEPEND=">=media-libs/allegro-4.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:/games::' \
		-e '/^MANDIR/ s:=.*:= $(mandir)/man6:' \
		-e '/^PIXDIR/ s:=.*:= /usr/share/pixmaps:' \
		-e '/^DESKTOPDIR/ s:=.*:= /usr/share/applnk/Games/:' \
		-e '/^INFODIR/ s/=.*/= $(infodir)/' \
		-e '/^GAMEDIR/ s/exec_prefix/bindir/' \
		-e 's:$(DOCDIR)/txt:$(DOCDIR):g' \
		-e 's:$(GMAKE):$(MAKE):' \
		-e '/^DOCDIR/ s:=.*:= /usr/share/doc/$(PF):' Makefile.in \
		|| die 'sed Makefile.in failed'
	sed -i \
		-e '/^GAMEDIR/ s/$(exec_prefix)/@bindir@/' \
		-e 's:/games::' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
}

src_compile() {
	# Fixes build problem with gcc3 and -march=pentium4
	replace-cpu-flags pentium4 pentium3
	egamesconf \
		--disable-doc-ps \
		--disable-doc-pdf \
		--disable-target-opt \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install_nolink || die "make install failed"
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	use nls || rm -f "${D}"/usr/share/doc/${PF}/README.*
	prepalldocs
	prepgamesdirs
}
