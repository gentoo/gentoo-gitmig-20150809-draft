# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mssqlserver/jdbc-mssqlserver-2.2.0040.ebuild,v 1.3 2005/05/27 13:12:33 gustavoz Exp $

inherit java-pkg

At="mssqlserver.tar"
S=${WORKDIR}
DESCRIPTION="JDBC driver for Microsoft SQL Server 2000."
SRC_URI="http://download.microsoft.com/download/4/1/d/41d3e9c0-64d1-451e-947b-7a4cba273b2d/mssqlserver.tar"
HOMEPAGE="http://tinyurl.com/3v7tc"
KEYWORDS="x86 ppc amd64"
LICENSE="MSjdbcEULA"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.1"
IUSE="doc"
RESTRICT="nomirror"

src_unpack() {
	tar xf ${DISTDIR}/${At}
	tar xf msjdbc.tar
}

src_compile() {
	einfo "This is a binary-only ebuild."
}

src_install() {
	dodoc read.me EULA.txt MSfixes.txt
	use doc && java-pkg_dohtml -r Help/*
	use doc && dodoc \
			books/books.pdf
			books/Msjdbcig/msjdbcig.pdf \
			books/Msjdbcref/msjdbcref.pdf
	java-pkg_dojar lib/*.jar
}
