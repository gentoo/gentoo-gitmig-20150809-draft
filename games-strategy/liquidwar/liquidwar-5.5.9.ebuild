# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.5.9.ebuild,v 1.3 2003/11/07 08:42:04 hythloday Exp $

inherit games flag-o-matic

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://freesoftware.fsf.org/download/liquidwar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">media-libs/allegro-4.0"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Because we work around some Makefile issues the "helpful" messages
	# that get printed are wrong for Gentoo.  So we take them out lest
	# they be confusing.
	sed -i \
		-e '/@echo/d' Makefile.in || \
			die "sed Makefile.in failed"

	epatch ${FILESDIR}/liquidwar-gcc-3.3-fix.patch
}

src_compile() {
	# Fixes build problem with gcc3 and -march=pentium4
	replace-flags "-march=pentium4" "-march=pentium3"

	# needs to be econf and not egamesconf.  Otherwise we end up
	# with too many /games/ all over the place.
	econf --disable-doc-ps --disable-doc-pdf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	cd ${D}/usr/games
	dogamesbin ${D}/usr/games/{liquidwar,liquidwar-server} || \
		die "dogamesbin failed"
	rm -f ${D}/usr/games/{liquidwar,liquidwar-server}
	rm -rf ${D}/usr/bin
	prepgamesdirs
}
