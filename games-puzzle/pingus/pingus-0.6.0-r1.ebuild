# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.17 2006/11/04 04:56:55 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils flag-o-matic games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 x86"
IUSE="nls opengl"

RDEPEND="media-libs/hermes
	=dev-games/clanlib-0.6.5*
	dev-libs/libxml2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc.patch #28281 #63773
	epatch "${FILESDIR}"/${P}-build.patch
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	replace-flags -Os -O2
	egamesconf \
		$(use_enable nls) \
		$(use_with opengl clanGL) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	make_desktop_entry pingus Pingus
	prepgamesdirs
}
