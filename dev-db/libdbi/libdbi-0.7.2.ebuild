# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi/libdbi-0.7.2.ebuild,v 1.7 2005/02/28 00:44:19 trapni Exp $

DESCRIPTION="libdbi implements a database-independent abstraction layer in C, similar to the DBI/DBD layer in Perl."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND="
	>=sys-apps/sed-4"
RDEPEND=""
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"
SLOT=0

src_compile() {
	# should append CFLAGS, not replace them
	sed -i.orig -e 's/^CFLAGS = /CFLAGS += /g' src/Makefile.in

	econf || die
	emake || die
}

src_install () {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING README README.osx TODO
}
