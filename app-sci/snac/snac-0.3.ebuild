# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/snac/snac-0.3.ebuild,v 1.5 2003/11/22 22:50:12 dholm Exp $

DESCRIPTION="SNAC's a Neat Algebraic Calculator."
SRC_URI="http://snac.seul.org/${P}.tar.gz"
HOMEPAGE="http://snac.seul.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=x11-libs/gtk+-1.2.0
	gnome-base/libgnomeui"

src_unpack() {
	unpack ${A}
	cd ${S}/po

	mv Makefile.in.in  Makefile.in-orig
	sed -e "s:gnulocaledir = :gnulocaledir = ${D}:" Makefile.in-orig > Makefile.in.in
}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS
}
