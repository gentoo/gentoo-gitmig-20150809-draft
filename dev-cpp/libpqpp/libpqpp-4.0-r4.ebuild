# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpqpp/libpqpp-4.0-r4.ebuild,v 1.11 2006/11/11 02:19:53 dev-zero Exp $

inherit eutils
IUSE=""
MY_P=${P/pp/++}
DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="sparc x86"

DEPEND="virtual/libc >=dev-db/postgresql-7.3
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-PIC.patch
}

src_compile() {
	cp Makefile Makefile.backup
	sed -i "s|\$(POSTGRES_HOME)/lib|/usr/lib|g" Makefile || die
	sed -i "s|\$(POSTGRES_HOME)/include|/usr/include|g" Makefile || die
	emake || die
	cp Makefile.backup Makefile
}

src_install() {
	sed -i "s|ln -s \$(POSTGRES_HOME)/lib/|ln -s |" Makefile || die
	sed -i "s|\$(POSTGRES_HOME)/lib|${D}/usr/lib|" Makefile || die
	sed -i "s|\$(POSTGRES_HOME)/include|${D}/usr/include|g" Makefile || die
	dodir /usr/lib/postgresql /usr/include/postgresql
	einstall || die "Install failed"
}
