# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-io/commons-io-1.3.ebuild,v 1.2 2007/03/08 11:12:36 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_P="${P}-src"
DESCRIPTION="Commons-IO contains utility classes, stream implementations, file filters, and endian classes."
HOMEPAGE="http://jakarta.apache.org/commons/io"
SRC_URI="mirror://apache/jakarta/commons/io/source/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	test? (
		=dev-java/junit-3.8*
		dev-java/ant
	)
	!test? ( dev-java/ant-core )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	rm *.jar
	epatch ${FILESDIR}/${P}-build.xml.patch
	java-ant_ignore-system-classes
	java-ant_rewrite-classpath
}

src_test() {
	#By default libdir is ${HOME}/.maven so it can be /root/.maven
	ANT_OPTS="-Djava.io.tmpdir=${T}" eant test \
		-Dgentoo.classpath="$(java-pkg_getjars junit)" \
		-Dlibdir="libdir"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	use doc && java-pkg_dojavadoc build/dist-build/${P}/docs
	use source && java-pkg_dosrc src/java/*
}
