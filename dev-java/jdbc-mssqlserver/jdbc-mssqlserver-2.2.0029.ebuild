# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mssqlserver/jdbc-mssqlserver-2.2.0029.ebuild,v 1.1 2003/05/14 18:08:53 absinthe Exp $

inherit java-pkg

At="mssqlserver.tar"
S=${WORKDIR}
DESCRIPTION="JDBC driver for Microsoft SQL Server 2000."
SRC_URI="http://download.microsoft.com/download/3/0/f/30ff65d3-a84b-4b8a-a570-27366b2271d8/mssqlserver.tar"
HOMEPAGE="http://www.microsoft.com/downloads/details.aspx?FamilyID=4f8f2f01-1ed7-4c4d-8f7b-3d47969e66ae&DisplayLang=en"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
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
	use doc && dohtml -r Help/*
	use doc && dodoc \
			books/books.pdf
			books/Msjdbcig/msjdbcig.pdf \
			books/Msjdbcref/msjdbcref.pdf
	java-pkg_dojar lib/*.jar
}
