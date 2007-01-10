# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-0.19-r1.ebuild,v 1.8 2007/01/10 17:34:15 hkbst Exp $

inherit eutils

DESCRIPTION="GTK+ bindings for guile"
SRC_URI="http://www.ping.de/sites/zagadka/guile-gtk/download/${P}.tar.gz"
HOMEPAGE="http://www.ping.de/sites/zagadka/guile-gtk/"
IUSE=""
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=dev-scheme/guile-1.4*
	=x11-libs/gtk+-1.2*"

src_compile() {
	epatch ${FILESDIR}/${P}-Makefile.in.patch
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall

	dodoc INSTALL README* COPYING AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/guile-gtk/examples
	doins ${S}/examples/*.scm ${S}/examples/*.xpm
}
