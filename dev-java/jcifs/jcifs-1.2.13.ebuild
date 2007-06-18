# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcifs/jcifs-1.2.13.ebuild,v 1.7 2007/06/18 17:22:37 flameeyes Exp $

JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Library that implements the CIFS/SMB networking protocol in Java"
SRC_URI="http://jcifs.samba.org/src/${P}.tgz"
HOMEPAGE="http://jcifs.samba.org/"
LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.4
	=dev-java/servletapi-2.4*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-ant_rewrite-classpath
	rm -v *.jar || die
}

EANT_EXTRA_ARGS="-DhasServlet=true"
EANT_GENTOO_CLASSPATH="servletapi-2.4"

src_install() {
	java-pkg_newjar ${P}.jar

	dodoc README.txt || die
	# other stuff besides javadocs
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/*
	use examples && java-pkg_doexamples examples
}
