# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsel/xsel-0.9.6.ebuild,v 1.3 2006/08/20 23:16:45 dberkholz Exp $

inherit autotools

DESCRIPTION="XSel is a command-line program for getting and setting the contents of the X selection."
HOMEPAGE="http://www.vergenet.net/~conrad/software/xsel"
SRC_URI="http://www.vergenet.net/~conrad/software/xsel/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_unpack() {

	unpack "${A}"

	cd "${S}"
	eautoconf

}

src_install() {

	make DESTDIR="${D}" install|| die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

}
