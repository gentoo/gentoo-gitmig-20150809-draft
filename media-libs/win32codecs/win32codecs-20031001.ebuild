# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-20031001.ebuild,v 1.2 2004/03/19 07:56:05 mr_bones_ Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Win32 binary codecs for video and audio playback support"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/rp9win32codecs-${PV}.tar.bz2
	quicktime? ( mirror://gentoo/qt6dlls-${PV}.tar.bz2
		mirror://gentoo/qtextras-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mplayerhq.hu/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE="quicktime"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/* ${WORKDIR}/rp9win32codecs/*
	use quicktime && doins ${WORKDIR}/qt6dlls/* ${WORKDIR}/qtextras/*
}
