# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20040916.ebuild,v 1.1 2004/10/23 15:20:28 chriswhite Exp $


DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/all-${PV}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE="quicktime real xanim"

S=${WORKDIR}/all-${PV}

src_install() {
	cd ${S}

	insinto /usr/lib/win32

	doins *.dll

	use real && doins *so.6.0
	use quicktime && doins *.qtx *.qts
	use xanim && doins *.xa
}
