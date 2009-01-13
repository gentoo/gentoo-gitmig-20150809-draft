# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kobodeluxe/kobodeluxe-0.5.1.ebuild,v 1.6 2009/01/13 01:01:10 mr_bones_ Exp $

inherit eutils games

MY_P="KoboDeluxe-${PV/_/}"
DESCRIPTION="An SDL port of xkobo, a addictive space shoot-em-up"
HOMEPAGE="http://www.olofson.net/kobodl/"
SRC_URI="http://www.olofson.net/kobodl/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc29.patch
	# Fix paths
	sed -i \
		-e 's:\$(datadir)/kobo-deluxe:$(datadir)/kobodeluxe:' \
		-e 's:\$(sharedstatedir)/kobo-deluxe/scores:$(localstatedir)/kobodeluxe:' \
		configure || die "sed configure failed"
	sed -i \
		-e 's:kobo-deluxe:kobodeluxe:' \
		data/gfx/Makefile.in \
		data/sfx/Makefile.in || die "sed data/Makefile.in failed"
	tar xzvf icons.tar.gz || die "unpacking icons failed"
}

src_compile() {
	egamesconf $(use_enable opengl) || die
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon icons/KDE/icons/32x32/kobodl.png ${PN}.png
	make_desktop_entry kobodl "Kobo Deluxe"
	dodoc ChangeLog README* TODO
	prepgamesdirs
	fperms 2775 "${GAMES_STATEDIR}"/${PN}
}
