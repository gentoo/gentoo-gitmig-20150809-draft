# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/adaptx/adaptx-0.9.13_p20041105.ebuild,v 1.1 2004/12/04 18:21:37 karltk Exp $

inherit java-pkg

DESCRIPTION="Adaptx is an XSLT processor and XPath engine"
HOMEPAGE="http://project.exolab.org/cgi-bin/viewcvs.cgi/adaptx/?cvsroot=adaptx"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${PN}-20041105.gentoo.tar.bz2"
LICENSE="Exolab"
RDEPEND="virtual/jre
	=dev-java/rhino-1.5*
	=dev-java/log4j-1.2*
	=dev-java/gnu-jaxp-1.0*
	=dev-java/xerces-2.6*"
DEPEND="virtual/jdk
	>=dev-java/ant-1.4
	${RDEPEND}"
SLOT="0.9"
KEYWORDS="x86 ~amd64"
IUSE="doc"

S=${WORKDIR}/adaptx-20041105

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	java-pkg_jar-from xerces-2 xercesImpl.jar
	java-pkg_jar-from xerces-2 xml-apis.jar
	java-pkg_jar-from rhino
	java-pkg_jar-from gnu-jaxp
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from log4j
}

src_compile() {
	cd src/
	# tried to build sources with jikes but
	# failed all the time on different
	# plattforms (amd64, x86)
	antflags="jar"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/*.jar
	use doc && java-pkg_dohtml -r build/doc/javadoc/*
	cd build/classes
	dodoc CHANGELOG README LICENSE
}
