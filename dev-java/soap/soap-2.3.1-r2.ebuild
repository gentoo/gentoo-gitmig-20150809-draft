# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/soap/soap-2.3.1-r2.ebuild,v 1.3 2008/05/08 14:49:46 opfer Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_P=${P//./_}
DESCRIPTION="Apache SOAP (Simple Object Access Protocol) is an implementation of the SOAP submission to W3C"
HOMEPAGE="http://ws.apache.org/soap/"
SRC_URI="mirror://apache/ws/soap/version-${PV}/soap-src-${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

CDEPEND="java-virtuals/javamail
	dev-java/sun-jaf
	=dev-java/servletapi-2.4*
	>=dev-java/xerces-2.7"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	${CDEPEND}"
JAVA_PKG_FILTER_COMPILER="jikes"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# get rid of automagical tests, add gentoo.classpath to <javac>
	epatch "${FILESDIR}/${P}-build.xml.patch"
	# javadoc is a stupid thing, why it has -source 1.4 if not for this?!
	if use doc; then
		find src -name "*.java" -exec sed -i s/enum/enum1/g "{}" ";" \
			|| die "failed to rewrite enum keywords"
	fi
}

src_compile() {
	local gcp="$(java-pkg_getjars javamail,sun-jaf,xerces-2,servletapi-2.4)"
	eant "-Dgentoo.classpath=\"${gcp}\"" compile $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	use doc && java-pkg_dojavadoc build/javadocs
	use source && java-pkg_dosrc src/org
}
