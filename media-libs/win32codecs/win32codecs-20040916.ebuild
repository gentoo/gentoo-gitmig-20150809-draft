# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20040916.ebuild,v 1.3 2004/10/23 23:45:13 chriswhite Exp $


DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/all-${PV}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE="quicktime real"

S=${WORKDIR}/all-${PV}

src_install() {
	cd ${S}

	if use real
	then
		mkdir -p ${D}/usr/lib/real
		mv *so.6.0 ${D}/usr/lib/real
	fi

	if use quicktime
	then
		mkdir -p ${D}/usr/lib/win32
		mv *.qtx *.qts qtmlClient.dll  ${D}/usr/lib/win32
	fi

	mkdir -p ${D}/usr/lib/win32
	mv *.dll ${D}/usr/lib/win32
}
