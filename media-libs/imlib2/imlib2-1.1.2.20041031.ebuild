# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.1.2.20041031.ebuild,v 1.1 2004/11/02 04:25:43 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

MY_P=${P/_/-}
DESCRIPTION="Version 2 of an advanced replacement library for libraries like libXpm"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"

IUSE="X gif jpeg mmx png tiff"

DEPEND="=media-libs/freetype-2*
	gif? ( media-libs/libungif
		>=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( media-libs/jpeg )
	tiff? ( >=media-libs/tiff-3.5.5 )
	X? ( virtual/x11 )"

src_compile() {
	local mymmx=""
	if [ "${ARCH}" == "amd64" ] ; then
		mymmx="--disable-mmx"
	else
		mymmx="`use_enable mmx`"
	fi

	export MY_ECONF="
		${mymmx} \
		`use_with X x` \
	"
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	docinto samples
	dodoc demo/*.c
}
