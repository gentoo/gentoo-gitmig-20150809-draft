# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1.ebuild,v 1.10 2004/11/04 01:42:18 geoman Exp $

inherit eutils

MY_P=${PN}_v${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc ~ppc-macos ~mips"

IUSE=""

RDEPEND="virtual/libc"
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