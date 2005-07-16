# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ehcache/ehcache-1.1.ebuild,v 1.3 2005/07/16 13:44:52 axxo Exp $

inherit java-pkg

DESCRIPTION="Ehcache is a pure Java, fully-featured, in-process cache."
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://ehcache.sourceforge.net"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc junit jikes"

RDEPEND=">=virtual/jre-1.4
		dev-java/commons-collections
		dev-java/concurrent-util
		dev-java/commons-logging"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		>=dev-java/ant-core-1.5
		jikes? ( dev-java/jikes )
		junit? ( dev-java/junit	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	unzip ${P}-src.zip || die
	rm *.jar
	rm -rf src/net/sf/ehcache/hibernate
}

src_compile() {
	mkdir ${S}/classes
	cd ${S}/src

	find . -name "*.java"| xargs javac -d ${S}/classes \
		-classpath $(java-pkg_getjars commons-logging,commons-collections)
	cd ${S}/classes
	jar cf ${S}/${P}.jar * || die
}

src_install() {
	cd ${S}
	java-pkg_newjar ${S}/${P}.jar ${PN}.jar
	dodoc *.txt ehcache.xml ehcache.xsd
	if use doc ; then
		unzip ${P}-javadoc.zip || die
		java-pkg_dohtml -r docs
	fi
}
