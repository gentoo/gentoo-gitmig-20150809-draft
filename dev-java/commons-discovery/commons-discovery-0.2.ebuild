# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-discovery/commons-discovery-0.2.ebuild,v 1.1 2003/04/23 02:14:59 absinthe Exp $

inherit jakarta-commons

S="${WORKDIR}/${P}-src/discovery"
DESCRIPTION="The Discovery component is about discovering, or finding, implementations for pluggable interfaces."
HOMEPAGE="http://jakarta.apache.org/commons/discovery.html"
SRC_URI="http://www.apache.org/dist/jakarta/commons/discovery/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/commons-logging-1.0
	>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="doc jikes junit"

src_compile() {
	[ -f LICENSE.txt ] && cp LICENSE.txt ../LICENSE
	echo "logger.jar=`java-config --classpath=commons-logging`" | sed s/\=.*:/\=/ >> build.properties
	jakarta-commons_src_compile myconf make
	use doc && jakarta-commons_src_compile makedoc
	
	# UGLY HACK
	mv ${S}/target/conf/MANIFEST.MF ${S}/target/classes/
	cd ${S}/target/classes
	zip -r ../${PN}-${PV}.jar org
}
