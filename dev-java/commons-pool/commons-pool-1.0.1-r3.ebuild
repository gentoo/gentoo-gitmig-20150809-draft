# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.0.1-r3.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="Jakarta-Commons component providing general purpose object pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/pool.html"
SRC_URI="mirror://apache/jakarta/commons/pool/src/pool-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=dev-java/commons-collections-2.0
	junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-2.0"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes junit"

src_compile() {
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" >> build.properties
	jakarta-commons_src_compile myconf make
	jakarta-commons_src_install dojar
	use doc && jakarta-commons_src_compile makedoc
	use doc && jakarta-commons_src_install html
}

