# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/fastdb/fastdb-2.55.ebuild,v 1.7 2007/01/31 13:34:04 genone Exp $

DESCRIPTION="OO-DBMS that holds all data in memory; interfaces for C/C++/Kylix"
HOMEPAGE="http://www.garret.ru/~knizhnik/fastdb.html"
SRC_URI="http://www.garret.ru/~knizhnik/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc"

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
	elog "The subsql binary has been renamed to subsql-fdb,"
	elog "to avoid a name clash with the GigaBase version of subsql"
}
