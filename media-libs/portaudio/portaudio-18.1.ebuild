# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.1.ebuild,v 1.3 2004/06/15 02:48:48 eradicator Exp $

inherit eutils

MY_P=${PN}_v${PV/./_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${MY_P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"

IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-use-fpic.patch
}

src_compile() {
	make -f Makefile.linux sharedlib || die
}

src_install() {
	dolib pa_unix_oss/libportaudio.so

	insinto /usr/include
	doins pa_common/portaudio.h

	dodoc docs/*
}
