# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ehcache/ehcache-1.2.4-r2.ebuild,v 1.1 2007/04/19 16:40:44 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ehcache is a pure Java, fully-featured, in-process cache."
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://ehcache.sourceforge.net"

LICENSE="Apache-2.0"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

COMMON_DEPEND="
	dev-java/commons-collections
	dev-java/commons-logging
	~dev-java/servletapi-2.4"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEPEND}
	source? ( app-arch/zip )
	>=dev-java/ant-core-1.5"

JAVA_PKG_WANT_SOURCE="1.4"
JAVA_PKG_WANT_TARGET="1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	use doc && unzip -qq ${P}-javadoc.zip

	mkdir src && cd src
	unzip -qq ../${P}-sources.jar

	# could use a USE flag, but would result in circular dep
	rm -rf net/sf/ehcache/hibernate

	cd ${S}
	rm -f *.jar *.zip

}

src_compile() {
	mkdir ${S}/classes
	cd ${S}/src

	find . -name "*.java" > ${T}/src.list
	ejavac -d ${S}/classes \
		-classpath 	$(java-pkg_getjars commons-logging,commons-collections,servletapi-2.4) \
		@${T}/src.list

	cp "${S}/ehcache.xml" "${S}/classes/ehcache-failsafe.xml" || die

	cd ${S}/classes
	jar cf ${S}/${PN}.jar * || die "failed to create jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc *.txt ehcache.xml ehcache.xsd
	use source && java-pkg_dosrc src/net
	use doc &&java-pkg_dojavadoc docs
}
