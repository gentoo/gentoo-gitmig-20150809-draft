# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpq++/libpq++-4.0.ebuild,v 1.1 2003/06/16 21:09:46 nakano Exp $

DESCRIPTION="C++ wrapper for the libpq Postgresql library"
HOMEPAGE="http://gborg.postgresql.org/"
SRC_URI="ftp://gborg.postgresql.org/pub/libpqpp/stable/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"
RDEPEND=">=dev-db/postgresql-7.3"

S=${WORKDIR}/${P}

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
