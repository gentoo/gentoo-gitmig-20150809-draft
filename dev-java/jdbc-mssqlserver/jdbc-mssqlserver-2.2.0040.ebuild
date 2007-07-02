# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mssqlserver/jdbc-mssqlserver-2.2.0040.ebuild,v 1.6 2007/07/02 14:32:47 peper Exp $

inherit java-pkg

At="mssqlserver.tar"
S=${WORKDIR}
DESCRIPTION="JDBC driver for Microsoft SQL Server 2000."
SRC_URI="http://download.microsoft.com/download/4/1/d/41d3e9c0-64d1-451e-947b-7a4cba273b2d/mssqlserver.tar"
HOMEPAGE="http://www.microsoft.com/downloads/details.aspx?familyid=07287b11-0502-461a-b138-2aa54bfdc03a&displaylang=en"
KEYWORDS="x86 ppc amd64"
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
	dodoc read.me EULA.txt MSfixes.txt
	use doc && java-pkg_dohtml -r Help/*
	use doc && dodoc \
			books/books.pdf \
			books/Msjdbcig/msjdbcig.pdf \
			books/Msjdbcref/msjdbcref.pdf
	java-pkg_dojar lib/*.jar
}
