# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20040703.ebuild,v 1.2 2005/01/16 20:13:59 luckyduck Exp $

RP_V="20040626"
QT_V="20040626"
QTE_V="20040704"
CODECS="releases/codecs"

DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="mirror://mplayer/${CODECS}/${P}.tar.bz2
	mirror://mplayer/${CODECS}/rp9codecs-win32-${RP_V}.tar.bz2
	quicktime? ( mirror://mplayer/${CODECS}/qt6dlls-${QT_V}.tar.bz2
		mirror://mplayer/${CODECS}/qtextras-${QTE_V}.tar.bz2 )"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE="quicktime"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/* ${WORKDIR}/rp9codecs-win32-${RP_V}/*
	use quicktime && doins ${WORKDIR}/qt6dlls-${QT_V}/* ${WORKDIR}/qtextras-${QTE_V}/*
}
