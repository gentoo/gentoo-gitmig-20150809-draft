# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fxred/fxred-0.7.ebuild,v 1.1 2002/09/09 04:49:09 mkennedy Exp $

DESCRIPTION="FXred is handler for the red scroll button of the Logitech TrackMan Marble FX, a trackball."
HOMEPAGE="http://www.larskrueger.homestead.com/files/index.html#X11"
SRC_URI="http://www.larskrueger.homestead.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="x11-base/xfree"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO
	dohtml fxred/docs/en/*.html
	insinto /etc
	doins fxredrc
}
