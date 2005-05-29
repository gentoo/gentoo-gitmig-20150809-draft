# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zphoto/zphoto-1.2-r1.ebuild,v 1.2 2005/05/29 18:54:22 usata Exp $

IUSE="wxwindows gtk2"

DESCRIPTION="A zooming photo album generator in Flash"
SRC_URI="http://namazu.org/~satoru/zphoto/${P}.tar.gz"
HOMEPAGE="http://namazu.org/~satoru/zphoto/"

SLOT="0"
KEYWORDS="x86"
LICENSE="LGPL-2.1"

DEPEND=">=media-libs/ming-0.2a
	|| ( >=media-libs/imlib2-1.1.0 >=media-gfx/imagemagick-5.5.7 )
	>=media-video/avifile-0.7.34
	app-arch/zip
	>=dev-libs/popt-1.6.3
	wxwindows? ( >=x11-libs/wxGTK-2.4.2-r2 )"

src_compile() {

	local myconf

	if use wxwindows ; then
		if use gtk2 ; then
			myconf="--with-wx-config=/usr/bin/wxgtk2-2.4-config"
		else
			myconf="--with-wx-config=/usr/bin/wxgtk-2.4-config"
		fi
	else
		myconf="--disable-wx"
	fi
	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
