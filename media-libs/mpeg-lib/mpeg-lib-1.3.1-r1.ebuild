# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mpeg-lib/mpeg-lib-1.3.1-r1.ebuild,v 1.21 2004/07/14 20:19:46 agriffis Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A lib for MPEG-1 video"
SRC_URI="ftp://ftp.mni.mcgill.ca/pub/mpeg/${MY_P}.tar.gz"
HOMEPAGE="http://starship.python.net/~gward/mpeglib/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha hppa amd64 mips"
IUSE=""

src_compile() {

	econf --disable-dither || die

	# Doesn't work with -j 4 (hallski)
	make OPTIMIZE="${CFLAGS}" || die

}

src_install () {

	make prefix=${D}/usr install || die
	dodoc CHANGES README
	docinto txt
	dodoc doc/image_format.eps doc/mpeg_lib.*

}
