# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-0.19.ebuild,v 1.4 2003/02/13 16:58:19 vapier Exp $

DESCRIPTION="GTK+ bindings for guile"
SRC_URI="http://www.ping.de/sites/zagadka/guile-gtk/download/${P}.tar.gz"
HOMEPAGE="http://www.ping.de/sites/zagadka/guile-gtk/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=dev-util/guile-1.4*
	=x11-libs/gtk+-1.2*"

src_compile() {
	patch < ${FILESDIR}/${P}-Makefile.in.patch || die "patch failed"
	econf
	emake || die
}

src_install() {
	einstall

	dodoc INSTALL README* COPYING AUTHORS Changelog NEWS TODO
	insinto ${D}/usr/share/guile-gtk/examples
	doins ${S}/examples/*.scm ${S}/examples/*.xpm
}
