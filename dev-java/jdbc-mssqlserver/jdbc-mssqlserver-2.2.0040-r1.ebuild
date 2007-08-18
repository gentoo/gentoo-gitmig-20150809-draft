# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mssqlserver/jdbc-mssqlserver-2.2.0040-r1.ebuild,v 1.3 2007/08/18 14:46:18 nixnut Exp $

inherit java-pkg-2

At="mssqlserver.tar"
S=${WORKDIR}
DESCRIPTION="JDBC driver for Microsoft SQL Server 2000."
SRC_URI="http://download.microsoft.com/download/4/1/d/41d3e9c0-64d1-451e-947b-7a4cba273b2d/mssqlserver.tar"
HOMEPAGE="http://www.microsoft.com/downloads/details.aspx?familyid=07287b11-0502-461a-b138-2aa54bfdc03a&displaylang=en"
KEYWORDS="~amd64 ppc ~x86"
LICENSE="MSjdbcEULA"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jre-1.1"
IUSE="doc"
RESTRICT="mirror"

src_unpack() {
	tar xf ${DISTDIR}/${At} || die
	tar xf msjdbc.tar || die
}

src_install() {
	dodoc read.me EULA.txt MSfixes.txt || die
	if use doc; then
		dohtml -r Help/*
		dodoc \
			books/books.pdf \
			books/Msjdbcig/msjdbcig.pdf \
			books/Msjdbcref/msjdbcref.pdf || die
	fi
	java-pkg_dojar lib/*.jar
}
