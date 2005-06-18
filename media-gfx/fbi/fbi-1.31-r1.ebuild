# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.31-r1.ebuild,v 1.4 2005/06/18 15:02:18 corsair Exp $

inherit toolchain-funcs

DESCRIPTION="A image viewer for the Linux framebuffer console."
HOMEPAGE="http://linux.bytesex.org/fbida/"
SRC_URI="http://dl.bytesex.org/releases/fbida/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ppc64 ~sparc x86"
IUSE="png jpeg gif tiff curl lirc X"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )
	<media-libs/libexif-0.6.10
	!media-gfx/fbida"

src_unpack() {
	unpack ${A}
	sed -e 's/DGifOpenFileName,ungif/DGifOpenFileName,gif/' \
	    -e 's/-lungif/-lgif/' -i ${S}/GNUmakefile
	sed -i -e 's/ps\*.jpeg/ps*.tiff/g' ${S}/fbgs
}

src_compile() {
	export CFLAGS="${CFLAGS}"
	make CC="$(tc-getCC)" || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
	dodoc README
}
