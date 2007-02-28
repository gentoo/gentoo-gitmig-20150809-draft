# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1.ebuild,v 1.17 2007/02/28 22:15:41 genstef Exp $

inherit eutils

MY_P=${PN}_v${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="18"
KEYWORDS="amd64 hppa ~mips ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-use-fpic.patch
	use ppc-macos && cp ${FILESDIR}/${PN}-Makefile.macos ${S}/Makefile || \
	cp ${S}/Makefile.linux ${S}/Makefile
}

src_compile() {
	cd ${S}
	make sharedlib || die
}

src_install() {
	if ! use ppc-macos
	then
		dolib pa_unix_oss/libportaudio.so
	else
		dolib pa_mac_core/libportaudio.dylib
	fi

	insinto /usr/include
	doins pa_common/portaudio.h

	dodoc docs/*
}
