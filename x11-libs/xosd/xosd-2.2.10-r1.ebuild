# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.10-r1.ebuild,v 1.4 2007/07/22 03:11:37 dberkholz Exp $

inherit eutils

IUSE="xinerama"

DESCRIPTION="Library for overlaying text/glyphs in X-Windows X-On-Screen-Display plus binary for sending text from command line"
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~sparc x86"

DEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto"

src_compile() {
	local myconf=""

	use xinerama || myconf="${myconf} --disable-xinerama"

	myconf="${myconf} --disable-new-plugin"

	econf ${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README

	if [ -d ${D}no ]; then
		rmdir ${D}no
	fi
}
