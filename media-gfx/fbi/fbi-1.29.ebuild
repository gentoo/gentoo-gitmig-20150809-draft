# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.29.ebuild,v 1.2 2004/02/15 11:44:14 dholm Exp $

IUSE="png jpeg gif tiff curl lirc"

S="${WORKDIR}/${P}"
DESCRIPTION="fbi a framebuffer image viewer"
SRC_URI="http://bytesex.org/misc/${P/-/_}.tar.gz"
HOMEPAGE="http://bytesex.org/fbi.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/libungif )
	tiff? ( media-libs/tiff )
	curl? ( net-ftp/curl )
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )"

src_compile() {
	export CFLAGS="${CFLAGS}"
	make CC=gcc || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc COPYING README
}
