# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cxx/log4cxx-0.9.5.ebuild,v 1.5 2004/07/14 14:59:44 agriffis Exp $

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations"
HOMEPAGE="http://log4cxx.sourceforge.net/"
SRC_URI="mirror://sourceforge/log4cxx/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/libc
		dev-libs/libxml2"
RDEPEND=""


src_compile() {
	./autogen.sh
	econf || die "./configure failed"
	make || die
}

src_install () {
	make prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
}
