# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back/gnustep-back-0.8.5-r1.ebuild,v 1.2 2004/07/23 15:00:18 fafhrd Exp $

inherit base gnustep-old

DESCRIPTION="GNUstep GUI backend"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
IUSE=""
DEPEND="=gnustep-base/gnustep-gui-${PV}*
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b-r2
	>=media-libs/freetype-2*
	virtual/x11
	>=x11-wm/windowmaker-0.80.1"
PATCHES1="${FILESDIR}/${P}.xft2.patch"

GNUSTEPBACK_XFT=2

src_unpack() {
	base_src_unpack
	cd ${S}
	autoconf
}

src_compile() {

	local myconf

	# For a different graphics library... choose one
	#
	# myconf="--enable-graphics=xdps --with-name=xdps"
	#
	# -OR-
	#
	# make sure you have libart_lgpl installed and...
	#
	# myconf="--enable-graphics=art --with-name=art"

	egnustepmake \
		--prefix=/usr/GNUstep \
		--with-jpeg-library=/usr/lib \
		--with-jpeg-include=/usr/include \
		--with-tiff-library=/usr/lib \
		--with-tiff-include=/usr/include \
		--with-x ${myconf} || die "configure failed"
}
