# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/backport-util-concurrent/backport-util-concurrent-1.1.01-r1.ebuild,v 1.1 2006/07/03 00:53:33 nichoj Exp $

inherit java-pkg-2 java-ant-2

MY_PV="1.1_01" # TODO use versionator
MY_P="${PN}-${MY_PV}"
DESCRIPTION="This package is the backport of java.util.concurrent API, introduced in Java 5.0, to Java 1.4"
HOMEPAGE="http://www.mathcs.emory.edu/dcl/util/backport-util-concurrent/"
SRC_URI="http://www.mathcs.emory.edu/dcl/util/${PN}/dist/${MY_P}/${MY_P}-src.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="=virtual/jdk-1.4*
	dev-java/ant-core
	dev-java/junit"
RDEPEND="=virtual/jre-1.4*"

S="${WORKDIR}/${MY_P}-src"

ant_src_unpack() {
	unpack ${A}
	cd ${S}/external
	rm -f *.jar
	java-pkg_jar-from junit
}

src_compile() {
	eant javacompile archive $(use_doc)
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r doc/api
	java-pkg_dohtml README.html
}
