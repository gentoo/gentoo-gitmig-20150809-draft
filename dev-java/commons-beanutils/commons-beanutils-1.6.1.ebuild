# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.6.1.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="The Jakarta BeanUtils component provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils.html"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes junit"

src_compile() {
	cp LICENSE.txt ../LICENSE
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	echo "commons-logging.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
}
