# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/radeox/radeox-1.0_beta2-r1.ebuild,v 1.1 2007/01/12 12:39:24 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Radeox Wiki render engine"
HOMEPAGE="http://www.radeox.org"
SRC_URI="ftp://snipsnap.org/radeox/${PN}-1.0-BETA-2-src.tgz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
RDEPEND=">=virtual/jre-1.4
	=dev-java/commons-logging-1*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core"

S=${WORKDIR}/${PN}-1.0-BETA-2

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TOOD:
	# these would get bundled to the final jar
	# we should try to run the tests though
	rm -rf  src/org/radeox/example/ \
		src/test/ src/org/radeox/test/

	rm -v lib/*.jar
	cd lib
	java-pkg_jar-from commons-logging
}

EANT_BUILD_TARGET="jar jar-api"

src_install() {
	dodoc Changes.txt README Radeox.version || die
	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/org
	java-pkg_dojar lib/{radeox,radeox-api}.jar
}
