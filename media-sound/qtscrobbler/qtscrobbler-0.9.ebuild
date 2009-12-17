# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qtscrobbler/qtscrobbler-0.9.ebuild,v 1.3 2009/12/17 18:40:35 ssuominen Exp $

EAPI=1
inherit eutils qt4

MY_PN="qtscrob"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Updates a last.fm profile using information from a supported portable music player"
HOMEPAGE="http://qtscrob.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cli +qt4"

DEPEND="net-misc/curl
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	# Makefile for cli prog does not read CFLAGS env var.
	# This sed fixes this.
	cd "${S}/src/cli"
	sed -i -e "s:CFLAGS =.*:CFLAGS = \$(INCLUDE) `curl-config --cflags` ${CFLAGS}:" Makefile
}

src_compile() {
	if use cli; then
		cd "${S}/src/cli"
		emake || die "emake cli failed"
	fi
	if use qt4; then
		cd "${S}/src/qt"
		qmake "${MY_PN}.pro" || die "qmake qt4 gui failed"
		emake || die "emake qt4 gui failed"
	fi
}

src_install() {
	if use cli; then
		cd "${S}/src/cli"
		newbin scrobble-cli qtscrobbler-cli
	fi
	if use qt4; then
		cd "${S}/src/qt"
		newbin qtscrob qtscrobbler
		newicon resources/icons/128.png qtscrobbler.png
		make_desktop_entry qtscrobbler QtScrobbler
	fi
	cd "${S}"
	dodoc AUTHORS CHANGELOG README
}
