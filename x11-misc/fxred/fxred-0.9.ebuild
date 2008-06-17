# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fxred/fxred-0.9.ebuild,v 1.9 2008/06/17 12:39:45 nelchael Exp $

DESCRIPTION="a handler for the red scroll button of the Logitech TrackMan Marble
FX, a trackball."
HOMEPAGE="http://www.larskrueger.homestead.com/files/index.html#X11"
SRC_URI="http://www.larskrueger.homestead.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto
	x11-libs/libXt"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO.txt
	dohtml fxred/docs/en/*.html
	insinto /etc
	doins fxredrc
}
