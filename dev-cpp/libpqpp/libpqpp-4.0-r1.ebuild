# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpqpp/libpqpp-4.0-r1.ebuild,v 1.1 2004/01/16 16:24:09 nakano Exp $

DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"
RDEPEND=">=dev-db/postgresql-7.3"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_compile() {
	sed "s|^POSTGRES_HOME=/usr/local/pgsql$|POSTGRES_HOME=/usr|g" Makefile > Makefile.new &&
	mv Makefile.new Makefile
	emake
	sed "s|^POSTGRES_HOME=/usr$|POSTGRES_HOME=\${D}usr|g" Makefile > Makefile.new &&
	mv Makefile.new Makefile
	sed "s|^\tln -s .*$|\tln -s \$(soname) \$(POSTGRES_HOME)/lib/\$(TARGET).so|g" Makefile > Makefile.new &&
	mv Makefile.new Makefile
	emake
}

src_install() {
	dodir /usr/lib /usr/include
	einstall install || die "Install failed"
}
