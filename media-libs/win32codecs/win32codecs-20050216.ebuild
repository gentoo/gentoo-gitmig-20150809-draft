# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20050216.ebuild,v 1.8 2007/07/12 03:10:24 mr_bones_ Exp $

DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="mirror://mplayer/releases/codecs/all-${PV}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="quicktime real"

RDEPEND="real? ( =virtual/libstdc++-3.3* )"

S=${WORKDIR}/all-${PV}

src_install() {
	cd ${S}

	# see #83221
	insopts -m0644
	dodir /usr/lib/win32

	if use real
	then
		dodir /usr/lib/real
		insinto /usr/lib/real
		doins *so.6.0

		# copy newly introduced codecs from realplayer10
		# see the ChangeLog online
		doins *.so

		# fix bug #80321
		ln -s ${D}/usr/lib/real/* ${D}/usr/lib/win32/
	fi

	insinto /usr/lib/win32
	if use quicktime
	then
		doins *.qtx *.qts qtmlClient.dll
	fi

	doins *.dll *.ax *.xa *.acm *.vwp *.drv *.DLL

	dodoc README
}
