# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm/aewm-1.2.0.ebuild,v 1.4 2003/09/06 04:16:42 msterret Exp $

IUSE=""

DESCRIPTION="A minimalistic X11 window manager."
HOMEPAGE="http://www.red-bean.com/%7Edecklin/aewm/"
SRC_URI="http://www.red-bean.com/%7Edecklin/aewm/${P}.tar.gz"
LICENSE="aewm"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*"

S="${WORKDIR}/${P}"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	make DESTDIR=${D} XROOT=/usr MANDIR=${D}/usr/share/man/man1 install || die
	dodoc ChangeLog README LICENSE
}

pkg_postinst() {
	einfo "See /usr/share/doc/${P}/README.gz for some delicious ~/.xinitrc recipes"
}
