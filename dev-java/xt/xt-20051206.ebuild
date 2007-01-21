# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-20051206.ebuild,v 1.1 2007/01/21 22:44:15 betelgeuse Exp $

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="http://www.blnz.com/xt/${P}-src.zip"
HOMEPAGE="http://www.blnz.com/xt/"

LICENSE="JamesClark"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

COMMON_DEP="~dev-java/servletapi-2.4"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND="
	!doc? ( >=virtual/jdk-1.4 )
	doc? ( || ( =virtual/jdk-1.4* =virtual/jdk-1.5* ) )
	${COMMON_DEP}
	app-arch/unzip
	dev-java/ant-core"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/20051206-java5.patch
	rm -v lib/*.jar || die
	rm thirdparty/servlet/*.jar || die
	rm -vr ant || die
	cd lib
	java-pkg_jar-from servletapi-2.4 servlet-api.jar servlets.jar
	#Loads these at runtime only
	java-pkg_getjars xp >/dev/null
}

EANT_BUILD_TARGET="compile"
EANT_EXTRA_ARGS="-Dunzip.done=true"

src_install() {
	java-pkg_newjar lib/${PN}${PV}.jar
	java-pkg_dolauncher ${PN} \
		--main com.jclark.xsl.sax.Driver
	dodoc README.txt || die
	dohtml index.html || die
	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/xt/java/com
}
