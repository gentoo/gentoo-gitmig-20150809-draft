# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zphoto/zphoto-1.2-r2.ebuild,v 1.8 2010/02/24 19:56:22 ssuominen Exp $

EAPI=2
inherit wxwidgets eutils

DESCRIPTION="A zooming photo album generator in Flash"
SRC_URI="http://namazu.org/~satoru/zphoto/${P}.tar.gz"
HOMEPAGE="http://namazu.org/~satoru/zphoto/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="wxwidgets"

DEPEND=">=media-libs/ming-0.2a
	|| ( >=media-libs/imlib2-1.1.0 >=media-gfx/imagemagick-5.5.7 )
	app-arch/zip
	>=dev-libs/popt-1.6.3
	wxwidgets? ( =x11-libs/wxGTK-2.6*[X] )"
RDEPEND="${DEPEND}"

src_prepare(){
	#bug 273831
	epatch "${FILESDIR}"/"${P}"-glibc210.patch
}

src_configure() {

	local myconf="${myconf} --disable-avifile"

	if use wxwidgets; then
		WX_GTK_VER="2.6"
		need-wxwidgets gtk2
		myconf="${myconf} --with-wx-config=${WX_CONFIG}"
		sed -i -e 's@FALSE@false@g' wxzphoto.cpp || die
	else
		myconf="${myconf} --disable-wx"
	fi

	econf ${myconf}
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
