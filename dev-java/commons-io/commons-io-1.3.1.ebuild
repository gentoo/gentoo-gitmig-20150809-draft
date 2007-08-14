# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-io/commons-io-1.3.1.ebuild,v 1.7 2007/08/14 07:24:01 opfer Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_P="${P}-src"
DESCRIPTION="Commons-IO contains utility classes, stream implementations, file filters, and endian classes."
HOMEPAGE="http://jakarta.apache.org/commons/io"
SRC_URI="mirror://apache/jakarta/commons/io/source/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="test"

DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	rm -v *.jar || die
	epatch "${FILESDIR}/${P}-build.xml.patch"
	java-ant_ignore-system-classes
	java-ant_rewrite-classpath
}

src_test() {
	if hasq userpriv ${FEATURES}; then
		#By default libdir is ${HOME}/.maven so it can be /root/.maven
		ANT_OPTS="-Djava.io.tmpdir=${T}" \
		ANT_TASKS="ant-junit" \
			eant test \
			-Dgentoo.classpath="$(java-pkg_getjars junit)" \
			-Dlibdir="libdir"
	else
		elog "Tests require userpriv in FEATURES because they test"
		elog "accessing files which always succeeds for root."
	fi
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	use doc && java-pkg_dojavadoc build/dist-build/${P}/docs
	use source && java-pkg_dosrc src/java/*
}
