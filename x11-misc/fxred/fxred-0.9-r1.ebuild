# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fxred/fxred-0.9-r1.ebuild,v 1.1 2010/02/07 16:30:37 jer Exp $

EAPI="2"

DESCRIPTION="a handler for the red scroll button of the Logitech TrackMan Marble
FX, a trackball."
HOMEPAGE="http://www.larskrueger.homestead.com/files/index.html#X11"
SRC_URI="http://www.larskrueger.homestead.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto
	x11-libs/libXt"

src_prepare() {
	sed -i configure -e '/^CFLAGS="-O2 -Wall"/d' || die "sed failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO.txt
	dohtml fxred/docs/en/*.html
	insinto /etc
	doins fxredrc
}
