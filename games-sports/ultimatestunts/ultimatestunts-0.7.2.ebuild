# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/ultimatestunts/ultimatestunts-0.7.2.ebuild,v 1.2 2007/08/24 18:18:48 wolf31o2 Exp $

inherit autotools eutils versionator games

MY_P=${PN}-srcdata-$(replace_all_version_separators)1
DESCRIPTION="Remake of the famous Stunts game"
HOMEPAGE="http://www.ultimatestunts.nl/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/openal
	media-libs/freealut
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/cvs
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup
	if ! built_with_use media-libs/libsdl opengl ; then
		die "Please emerge libsdl with USE=opengl"
	fi
	if ! built_with_use media-libs/openal vorbis ; then
		die "Please emerge openal with USE=vorbis"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-paths.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
	autopoint -f || die "autopoint failed"
	sed -i 's:$(datadir)/locale:@top_srcdir@/data/lang:' po/Makefile.in.in \
		|| die "sed failed"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		|| die
	emake -C trackedit libtrackedit.a || die "emake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/cars/diablo/steer.png ${PN}.png
	make_desktop_entry ustunts "Ultimate Stunts"
	dodoc AUTHORS README
	rm -rf $(find "${D}" -name CVS)
	prepgamesdirs
}
