# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdgear/vcdgear-1.6e.ebuild,v 1.1 2002/10/23 14:04:59 vapier Exp $

DESCRIPTION="extract MPEG streams from CD images, convert VCD files to MPEG, correct MPEG errors, and more"
HOMEPAGE="http://www.vcdgear.com/"

STC_P="vcdgear16_static-e"
DYN_P="vcdgear16-e"

[ `use static` ] \
	&& SRC_URI="http://www.vcdgear.com/files/${STC_P}.tar.gz" \
	|| SRC_URI="http://www.vcdgear.com/files/${DYN_P}.tar.gz"
S="${WORKDIR}/vcdgear"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -sparc64 -alpha"
IUSE="static"

DEPEND=""
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv `ls` vcdgear
}

src_install() {
	dodoc CREDITS FAQ HISTORY MANUAL WHATSNEW
	into /opt
	dobin vcdgear16
}
