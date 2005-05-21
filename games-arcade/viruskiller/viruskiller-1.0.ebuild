# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/viruskiller/viruskiller-1.0.ebuild,v 1.1 2005/05/21 19:49:43 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="Simple arcade game, shoot'em up style, where you must defend your file system from invading viruses"
HOMEPAGE="http://www.parallelrealities.co.uk/virusKiller.php"
# download page has a lame PHP thing.
SRC_URI="mirror://gentoo/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^ICONDIR = /s:icons:pixmaps:" \
		-e "/^BINDIR = /s:/$:/bin/:" \
		-e "/^DOCDIR = /s:doc/.*:doc/${PF}/html/:" \
		-e "/^\(KDE\|GNOME\) = /s:=.*:= \$(DESTDIR)/usr/share/applications:" \
		makefile \
		|| die "sed failed"
	rm -f doc/LICENSE
	mv doc/README "${S}"
}

src_compile() {
	append-flags -fsigned-char
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
	prepgamesdirs
}
