# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-0.19-r1.ebuild,v 1.3 2004/02/29 15:04:38 aliz Exp $

DESCRIPTION="GTK+ bindings for guile"
SRC_URI="http://www.ping.de/sites/zagadka/guile-gtk/download/${P}.tar.gz"
HOMEPAGE="http://www.ping.de/sites/zagadka/guile-gtk/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=dev-util/guile-1.4*
	=x11-libs/gtk+-1.2*"

src_compile() {
	epatch ${FILESDIR}/${P}-Makefile.in.patch
	econf
	emake || die
}

src_install() {
	einstall

	dodoc INSTALL README* COPYING AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/guile-gtk/examples
	doins ${S}/examples/*.scm ${S}/examples/*.xpm
}
