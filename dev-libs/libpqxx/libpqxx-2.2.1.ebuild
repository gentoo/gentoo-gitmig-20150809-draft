# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-2.2.1.ebuild,v 1.4 2004/07/02 04:48:25 eradicator Exp $

IUSE=""
DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL. Supersedes older libpq++ interface."
SRC_URI="ftp://gborg.postgresql.org/pub/libpqxx/stable/${P}.tar.gz"
HOMEPAGE="http://gborg.postgresql.org/project/libpqxx/projdisplay.php"

LICENSE="POSTGRESQL"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND="virtual/libc
	>=gcc-2.95"

src_compile() {
	econf --enable-shared || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
	dohtml doc/html/Reference/*.html
}
