# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.62.3.ebuild,v 1.13 2004/11/01 18:04:33 pylon Exp $

inherit gnuconfig

DESCRIPTION="Tabular Datastream Library"
HOMEPAGE="http://www.freetds.org/"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE="odbc mssql"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

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
