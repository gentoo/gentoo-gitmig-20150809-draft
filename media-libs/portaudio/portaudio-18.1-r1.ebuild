# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1-r1.ebuild,v 1.2 2005/07/21 04:13:47 kito Exp $

inherit eutils

MY_P=${PN}_v${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc-macos ~sparc ~x86"

IUSE=""

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-use-fpic.patch
	use userland_Darwin  && cp ${FILESDIR}/${PN}-Makefile.macos ${S}/Makefile || \
	cp ${S}/Makefile.linux ${S}/Makefile
}

src_compile() {
	cd ${S}
	make sharedlib || die

	if ! use userland_Darwin ; then
		echo gcc -c ${CFLAGS} -fPIC -Ipa_common pablio/pablio.c -o pablio/pablio.o
		gcc -c ${CFLAGS} -fPIC -Ipa_common pablio/pablio.c -o pablio/pablio.o || die
		echo gcc -shared -o pablio/libpablio.so pablio/pablio.o
		gcc -shared -o pablio/libpablio.so pablio/pablio.o -Lpa_common -lportaudio || die
	fi
}

src_install() {
	if use userland_Darwin ; then
		dolib pa_mac_core/libportaudio.dylib
	else
		dolib pa_unix_oss/libportaudio.so pablio/libpablio.so
	fi

	insinto /usr/include/portaudio
	doins pa_common/portaudio.h pablio/pablio.h pablio/ringbuffer.h
	dosym portaudio/portaudio.h /usr/include/portaudio.h

	dodoc docs/*
}
