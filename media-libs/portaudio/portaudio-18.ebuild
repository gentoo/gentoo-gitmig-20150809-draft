# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-18.ebuild,v 1.1 2002/10/13 23:33:05 verwilst Exp $

S=${WORKDIR}/portaudio_v${PV}
DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://www.portaudio.com/archives/portaudio_v${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	
	make -f Makefile.linux sharedlib || die

}

src_install() {
	
	mkdir -p ${D}/usr/lib
	cp -f ./pa_unix_oss/libportaudio.so ${D}/usr/lib || die
	mkdir -p ${D}/usr/include
	cp ./pa_common/portaudio.h ${D}/usr/include || die
	mkdir -p ${D}/usr/share/doc/portaudio-18
	cp ./docs/* ${D}/usr/share/doc/portaudio-18 || die

}
