# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.0-r2.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

inherit jakarta-commons

S=${WORKDIR}/${PN}-${PV}-src
DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/dbcp.html"
SRC_URI="mirror://apache/jakarta/commons/dbcp/source/dbcp-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		>=dev-java/commons-collections-2.0
		>=dev-java/commons-pool-1.0.1"
RDEPEND=">=virtual/jre-1.3
		>=dev-java/commons-pool-1.0.1"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes"

src_compile() {
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties
	echo "commons-pool.jar=`java-config --classpath=commons-pool`" >> build.properties
	cp LICENSE.txt ../LICENSE
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
}
