# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gigabase/gigabase-3.02.ebuild,v 1.1 2004/03/29 17:49:58 rphillips Exp $

DESCRIPTION="OO-DBMS with interfaces for C/C++/Java/PHP/Perl"
HOMEPAGE="http://www.garret.ru/~knizhnik/gigabase.html"
SRC_URI="http://www.garret.ru/~knizhnik/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/gigabase

src_compile() {
	mf="${S}/Makefile"

	econf

	sed -r -e 's/subsql([^\.]|$)/subsql-gdb\1/' ${mf} > ${mf}.tmp
	mv ${mf}.tmp ${mf}

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc CHANGES
	dohtml GigaBASE.htm
	dohtml -r docs/html/*
}

pkg_postinst() {
	einfo "The subsql binary has been renamed to subsql-gdb,"
	einfo "to avoid a name clash with the FastDB version of subsql"
}
