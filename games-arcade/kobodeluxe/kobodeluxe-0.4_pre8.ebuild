# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kobodeluxe/kobodeluxe-0.4_pre8.ebuild,v 1.2 2004/01/24 12:40:52 mr_bones_ Exp $

inherit games

IUSE="opengl"

DESCRIPTION="An SDL port of xkobo, a addictive space shoot-em-up"
HOMEPAGE="http://www.olofson.net/kobodl/"
KEYWORDS="x86"
LICENSE="GPL-2"

MY_P="KoboDeluxe-${PV/_/}"
S=${WORKDIR}/${MY_P}
SRC_URI="http://www.olofson.net/kobodl/download/${MY_P}.tar.gz"

RDEPEND="virtual/glibc
	media-libs/libsdl
	media-libs/sdl-image
	opengl? ( virtual/opengl )"
DEPEND="$RDEPEND
	>=sys-apps/sed-4"

SLOT=0

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix paths
	sed -i \
		-e 's:\$(datadir)/games/kobo-deluxe:$(datadir)/kobodeluxe:' \
		-e 's:\$(prefix)/games/kobo-deluxe/scores:$(localstatedir)/kobodeluxe:' \
		configure || die "sed configure failed"
	sed -i \
		-e 's:\$(datadir)/games/kobo-deluxe:$(datadir)/kobodeluxe:' \
		data/Makefile.in || die "sed data/Makefile.in failed"
}

src_compile() {
	egamesconf `use_enable opengl` || die "./configure failed"
	emake || die
}

src_install () {
	make install DESTDIR=${D}

	dodoc ChangeLog README* TODO || die "dodoc failed"

	insinto /var/games/kobodeluxe
	doins 501 || die "doins failed"
	prepgamesdirs
	fperms 2775 /var/games/kobodeluxe
}

pkg_postinst() {

	einfo "The location of the highscore files has changed.  If this isn't the"
	einfo "first time you've installed ${PN} and you'd like to keep the high"
	einfo "scores from a previous version of ${PN}, please move all the files"
	einfo "in /var/lib/games/kobodeluxe/ to /var/games/kobodeluxe/. If you"
	einfo "have a /var/lib/games/kobodeluxe/ directory it may be removed."

	games_pkg_postinst
}
