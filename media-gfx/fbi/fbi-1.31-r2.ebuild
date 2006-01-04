# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.31-r2.ebuild,v 1.4 2006/01/04 05:58:05 halcy0n Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A image viewer for the Linux framebuffer console."
HOMEPAGE="http://linux.bytesex.org/fbida/"
SRC_URI="http://dl.bytesex.org/releases/fbida/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sh ~sparc x86"
IUSE="png jpeg gif tiff curl lirc X"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( media-libs/libpng )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	curl? ( net-misc/curl )
	lirc? ( app-misc/lirc )
	X? ( || ( <=x11-base/xorg-x11-6.99 x11-libs/libFS ) )
	media-libs/libexif
	!media-gfx/fbida"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's/DGifOpenFileName,ungif/DGifOpenFileName,gif/' \
	    -e 's/-lungif/-lgif/' -i GNUmakefile
	sed -i -e 's/ps\*.jpeg/ps*.tiff/g' fbgs
	epatch "${FILESDIR}"/${P}-strsignal.patch
	has_version ">=media-libs/libexif-0.6.10" && epatch "${FILESDIR}"/libexif-0.6.patch
}

src_compile() {
	make CC="$(tc-getCC)" || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
	dodoc README
}
