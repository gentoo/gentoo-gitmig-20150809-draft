# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-2.5.5.ebuild,v 1.3 2006/02/21 22:50:56 agriffis Exp $

inherit eutils
IUSE=""
DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL. Supersedes older libpq++ interface."
SRC_URI="ftp://gborg.postgresql.org/pub/libpqxx/stable/${P}.tar.gz
	http://gborg.postgresql.org/download/libpqxx/stable/${P}.tar.gz"
HOMEPAGE="http://gborg.postgresql.org/project/libpqxx/projdisplay.php"

LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

DEPEND="dev-db/libpq"

src_compile() {
#	epatch ${FILESDIR}/${P}-gentoo.patch
	econf --enable-shared || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README* TODO
	dohtml -r doc/html/*
}
