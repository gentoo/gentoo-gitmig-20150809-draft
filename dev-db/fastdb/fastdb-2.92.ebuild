# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/fastdb/fastdb-2.92.ebuild,v 1.1 2004/02/25 09:40:21 dholm Exp $

DESCRIPTION="OO-DBMS that holds all data in memory; interfaces for C/C++/Kylix"
HOMEPAGE="http://www.garret.ru/~knizhnik/fastdb.html"
SRC_URI="http://www.garret.ru/~knizhnik/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_compile() {
	mf="${S}/makefile"

	sed -r -e 's/subsql([^\.]|$)/subsql-fdb\1/' ${mf} > ${mf}.tmp
	mv ${mf}.tmp ${mf}

	emake || die
}

src_install() {
	make \
		PREFIX=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc CHANGES
	dohtml FastDB.htm
	dohtml -r docs/html/*
}

pkg_postinst() {
	einfo "The subsql binary has been renamed to subsql-fdb,"
	einfo "to avoid a name clash with the GigaBase version of subsql"
}
