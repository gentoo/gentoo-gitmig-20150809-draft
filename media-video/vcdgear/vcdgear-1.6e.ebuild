# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdgear/vcdgear-1.6e.ebuild,v 1.11 2004/07/03 09:05:06 kugelfang Exp $

MY_V="16"
MY_VR="e"
DESCRIPTION="extract MPEG streams from CD images, convert VCD files to MPEG, correct MPEG errors, and more"
HOMEPAGE="http://www.vcdgear.com/"
SRC_URI="!static? ( http://www.vcdgear.com/files/vcdgear${MY_V}_static-${MY_VR}.tar.gz )
	static? ( http://www.vcdgear.com/files/vcdgear${MY_V}-${MY_VR}.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE="static"

DEPEND=""
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv `ls` ${PN}
}

src_install() {
	dodoc CREDITS FAQ HISTORY MANUAL WHATSNEW
	into /opt
	dobin vcdgear16 || die
}
