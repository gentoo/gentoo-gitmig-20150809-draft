# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.90.ebuild,v 1.1 2002/11/25 04:14:43 vapier Exp $

S=${WORKDIR}/w32codec-${PV}
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="ftp://ftp.mplayerhq.hu/MPlayer/releases/w32codec.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/*
}
