# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/win32codecs/win32codecs-0.90.1.ebuild,v 1.1 2002/12/16 03:50:17 azarah Exp $

# Update codec pack from:
#
#   http://www.mplayerhq.hu/MPlayer/releases/codecs/win32codecs.tar.bz2

S="${WORKDIR}/${PN}"
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.mplayerhq.hu/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

src_install() {
	insinto /usr/lib/win32
	doins ${S}/*
}

