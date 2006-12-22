# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xstream/xstream-1.2.ebuild,v 1.4 2006/12/22 22:27:10 betelgeuse Exp $

inherit java-pkg-2

DESCRIPTION="A text-processing Java classes that serialize objects to XML and back again."
HOMEPAGE="http://xstream.codehaus.org/index.html"
SRC_URI="http://dist.codehaus.org/xstream/distributions/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples java5 source"

COMMON_DEPS="
	=dev-java/commons-lang-2.1*
	=dev-java/cglib-2.1*
	>=dev-java/dom4j-1.3
	dev-java/jsr173
	~dev-java/jdom-1.0
	=dev-java/jmock-1*
	>=dev-java/joda-time-1.2
	dev-java/xom
	>=dev-java/xpp3-1.1.3.4
	=dev-java/xml-commons-external-1.3*
"
DEPEND="java5? ( >=virtual/jdk-1.5 )
	!java5? ( =virtual/jdk-1.4* )
	>=dev-java/java-config-2.0.31
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )
	${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.4
	dev-java/jsr173
	${COMMON_DEPS}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar
	java-pkg_jar-from xml-commons-external-1.3
	java-pkg_jar-from jsr173
	java-pkg_jar-from cglib-2.1
	java-pkg_jar-from commons-lang-2.1
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from jdom-1.0
	java-pkg_jar-from jmock-1.0
	java-pkg_jar-from joda-time
	java-pkg_jar-from xom
	java-pkg_jar-from xpp3
}

src_install() {
	java-pkg_newjar ${P}.jar

	if use doc; then
		java-pkg_dohtml *.html
		java-pkg_dohtml -r docs/
	fi
	use source && java-pkg_dosrc src/java/com
}

