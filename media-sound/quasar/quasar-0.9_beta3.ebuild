# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quasar/quasar-0.9_beta3.ebuild,v 1.3 2008/07/27 21:41:04 carlo Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="Quasar Media Player is a micro media player for embedded devices"

HOMEPAGE="http://www.katastrophos.net/quasar"
SRC_URI="http://katastrophos.net/zaurus/sources/quasar/${P/-/_}_sources.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="x11-libs/qt:3
	>=media-libs/taglib-1.5
	>=dev-db/sqlite-3.5.6
	>=media-video/mplayer-1.0_rc2_p26753"

S=${WORKDIR}/v${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-use-system.patch"
}

src_compile() {
	eqmake3 quasar-qt.pro || die "eqmake3 failed"
	emake || die "emake failed"
}

src_install() {
	dobin quasar || die "dobin failed"
	insinto /usr/share/quasar/skins/default/
	doins distro/skins/default/*
	dodoc README

}
