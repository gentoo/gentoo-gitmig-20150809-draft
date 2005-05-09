# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avinfo/avinfo-1.0_alpha15.ebuild,v 1.4 2005/05/09 02:05:55 malc Exp $

inherit eutils

MY_P="${PN}-1.0a15"
DESCRIPTION="Utility for displaying AVI information"
HOMEPAGE="http://shounen.ru/soft/avinfo/english.shtml"
SRC_URI="http://shounen.ru/soft/avinfo/${MY_P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

IUSE=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_compile() {
	cd src
	emake CFLAGS="${CFLAGS}" OUTPUTNAME=avinfo || die
}

src_install() {
	dobin src/avinfo
	dodoc CHANGELOG README
	dodoc doc/*
}
