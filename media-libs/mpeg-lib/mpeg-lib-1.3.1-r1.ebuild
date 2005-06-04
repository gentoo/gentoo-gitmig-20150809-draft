# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mpeg-lib/mpeg-lib-1.3.1-r1.ebuild,v 1.23 2005/06/04 11:39:11 luckyduck Exp $

inherit multilib

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A lib for MPEG-1 video"
SRC_URI="ftp://ftp.mni.mcgill.ca/pub/mpeg/${MY_P}.tar.gz"
HOMEPAGE="http://starship.python.net/~gward/mpeglib/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha hppa amd64 mips"
IUSE=""

DEPEND="virtual/libc"

src_compile() {

	econf --disable-dither || die "configure failed"

	# Doesn't work with -j 4 (hallski)
	make OPTIMIZE="${CFLAGS}" || die "make failed"

}

src_install () {

	make INSTALL_LIBRARY="${D}/usr/$(get_libdir)" \
		 prefix="${D}/usr" install || die "make install failed"
	dodoc CHANGES README
	docinto txt
	dodoc doc/image_format.eps doc/mpeg_lib.*

}
