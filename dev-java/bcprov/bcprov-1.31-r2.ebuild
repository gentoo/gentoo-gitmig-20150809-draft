# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcprov/bcprov-1.31-r2.ebuild,v 1.1 2006/10/20 04:55:19 nichoj Exp $

inherit java-pkg-2 java-ant-2

MY_PN=${PN}-jdk14
MY_PV=${PV//./}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="The Bouncy Castle Crypto package is a Java implementation of cryptographic algorithms"
HOMEPAGE="http://www.bouncycastle.org/"
SRC_URI="http://www.bouncycastle.org/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build.xml ${S}
	cd ${S}
	# Get rid of the tests, since we aren't running them. This removes
	# a dependency on junit.
	rm src/org/bouncycastle/openssl/test/AllTests.java  src/org/bouncycastle/jce/provider/test/AllTests.java
}

src_compile() {
	eant ${antflags} -Dproject.name=${PN}
	mv docs api
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dohtml *.html
	use doc && java-pkg_dohtml -r api
}
