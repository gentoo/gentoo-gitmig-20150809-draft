# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.90.1-r2.ebuild,v 1.4 2004/03/19 07:56:05 mr_bones_ Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="http://www1.mplayerhq.hu/MPlayer/releases/codecs/${PN}.tar.bz2
	http://www1.mplayerhq.hu/MPlayer/releases/codecs/dmocodecs.tar.bz2
	http://www1.mplayerhq.hu/MPlayer/releases/codecs/rp9win32codecs.tar.bz2
	quicktime? ( http://www1.mplayerhq.hu/MPlayer/releases/codecs/qt6dlls.tar.bz2
		http://www1.mplayerhq.hu/MPlayer/releases/codecs/qtextras.tar.bz2 )"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha"
IUSE="quicktime"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/* ${WORKDIR}/dmocodecs/* ${WORKDIR}/rp9win32codecs/*
	use quicktime && doins ${WORKDIR}/qt6dlls/* ${WORKDIR}/qtextras/*
}
