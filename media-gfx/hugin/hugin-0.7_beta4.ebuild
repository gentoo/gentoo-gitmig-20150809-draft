# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-0.7_beta4.ebuild,v 1.2 2007/04/05 15:28:23 vanquirius Exp $

inherit wxwidgets eutils

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="unicode debug enblend sift"

DEPEND=">=media-libs/libpano12-2.8.4
		>=dev-libs/boost-1.30.0
		>=x11-libs/wxGTK-2.6.2
		sys-libs/zlib
		media-libs/libpng
		media-libs/jpeg
		media-libs/tiff
		enblend? ( >=media-gfx/enblend-2.4 )
		sift? ( media-gfx/autopano-sift )"

pkg_setup() {
	if ! built_with_use dev-libs/boost threads ; then
		local msg="Build dev-libs/boost with USE=threads"
		eerror "$msg"
		die "$msg"
	fi
	if ! use enblend; then
		einfo "It is recommended to emerge this package with the"
		einfo "enblend use flag to install media-gfx/enblend"
		einfo "that blends the seams between images in a panorama."
	fi
	if ! use sift; then
		einfo "It is recommended to emerge this package with the"
		einfo "sift use flag to install media-gfx/autopano-sift"
		einfo "that produces control points between images in a"
		einfo "panorama."
	fi
}

src_unpack() {
	unpack ${A}

	sed -i -e 's/autopanog\.exe/autopanog/' "${S}"/src/include/hugin/config_defaults.h
}

src_compile() {
	export WX_GTK_VER="2.6"

	if use unicode; then
		need-wxwidgets unicode || die "Emerge wxGTK with unicode in USE"
	else
		need-wxwidgets gtk2 || die "Emerge wxGTK with gtk2 in USE"
	fi

	myconf="`use_with unicode`
			`use_enable debug`"

	econf --with-wx-config="${WX_CONFIG}" ${myconf} || die "configure failed"
	emake || die "compiling failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS BUGS README TODO
}
