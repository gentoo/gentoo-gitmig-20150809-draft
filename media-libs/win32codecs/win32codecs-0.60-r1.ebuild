# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.60-r1.ebuild,v 1.3 2002/07/16 11:36:53 seemant Exp $

S=${WORKDIR}/w32codec-${PV}
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="ftp://ftp.mplayerhq.hu/MPlayer/releases/w32codec-${PV}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"

DEPEND=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

src_install() {

	insinto /usr/lib/win32
	doins ${S}/*
}
