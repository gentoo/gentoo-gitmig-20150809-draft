# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/ultimatestunts/ultimatestunts-0.6.2.ebuild,v 1.2 2006/10/05 16:10:57 nyhm Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
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
	media-libs/openal
	media-libs/freealut
	virtual/opengl
	virtual/glu
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXt
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-freealut.patch \
		"${FILESDIR}"/${P}-paths.patch

	autopoint -f || die "autopoint failed"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	make_desktop_entry ustunts "Ultimate Stunts"
	dodoc AUTHORS README

	rm -rf $(find "${D}" -name CVS)
	prepgamesdirs
}
