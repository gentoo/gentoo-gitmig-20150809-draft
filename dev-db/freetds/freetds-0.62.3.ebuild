# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.62.3.ebuild,v 1.5 2004/05/27 21:11:34 stuart Exp $

DESCRIPTION="Tabular Datastream Library"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tar.gz"
HOMEPAGE="http://www.freetds.org/"
IUSE="odbc mssql"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc ~mips ~hppa ~alpha amd64 ia64 s390"
DEPEND="virtual/glibc"

src_compile() {
	local myconf
	use odbc && myconf="--with-unixodbc=/usr"
	use mssql && myconf="${myconf} --enable-msdblib"
	econf --with-tdsver=7.0 ${myconf} --cache-file=${S}/config.cache || die "econf failed"
	emake || die
}

src_install() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e 's/^DEFDIR = /DEFDIR = $(DESTDIR)/' \
		${S}/Makefile.orig > ${S}/Makefile
	make DESTDIR=${D} install || die
}
