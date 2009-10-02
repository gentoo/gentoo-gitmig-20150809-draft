# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zphoto/zphoto-1.2-r2.ebuild,v 1.7 2009/10/02 22:52:45 maekke Exp $

EAPI=2

inherit wxwidgets eutils

IUSE="wxwindows"

DESCRIPTION="A zooming photo album generator in Flash"
SRC_URI="http://namazu.org/~satoru/zphoto/${P}.tar.gz"
HOMEPAGE="http://namazu.org/~satoru/zphoto/"

SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="LGPL-2.1"

DEPEND=">=media-libs/ming-0.2a
	|| ( >=media-libs/imlib2-1.1.0 >=media-gfx/imagemagick-5.5.7 )
	app-arch/zip
	>=dev-libs/popt-1.6.3
	wxwindows? ( =x11-libs/wxGTK-2.6*[X] )"
RDEPEND="${DEPEND}"

src_prepare(){
	#bug 273831
	epatch "${FILESDIR}"/"${P}"-glibc210.patch
}

src_configure() {

	local myconf="${myconf} --disable-avifile"

	if use wxwindows ; then
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

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
