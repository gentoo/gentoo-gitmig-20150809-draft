# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.31.ebuild,v 1.6 2004/06/24 22:36:36 agriffis Exp $

inherit gcc

DESCRIPTION="fbi a framebuffer image viewer"
HOMEPAGE="http://bytesex.org/fbi.html"
SRC_URI="http://bytesex.org/misc/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="png jpeg gif tiff curl lirc X"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/libungif )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )"

src_compile() {
	export CFLAGS="${CFLAGS}"
	make CC="$(gcc-getCC)" || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
	dodoc README
}
