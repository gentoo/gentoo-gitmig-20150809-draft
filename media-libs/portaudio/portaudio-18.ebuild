# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.ebuild,v 1.7 2004/03/25 01:39:23 eradicator Exp $

S=${WORKDIR}/${PN}_v${PV}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/${PN}_v${PV}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/glibc"

src_compile() {

	make -f Makefile.linux sharedlib || die

}

src_install() {

	dodir /usr/lib
	cp -f ./pa_unix_oss/libportaudio.so ${D}/usr/lib || die

	dodir /usr/include
	cp ./pa_common/portaudio.h ${D}/usr/include || die

	dodir /usr/share/doc/portaudio-18
	cp ./docs/* ${D}/usr/share/doc/portaudio-18 || die

}
