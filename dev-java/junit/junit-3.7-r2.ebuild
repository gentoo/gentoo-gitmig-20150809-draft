# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junit/junit-3.7-r2.ebuild,v 1.1 2003/03/14 05:32:00 absinthe Exp $

NP="junit3.7"
S=${WORKDIR}/${NP}
DESCRIPTION="simple framework to write repeatable tests"
SRC_URI="http://download.sourceforge.net/junit/${NP}.zip"
HOMEPAGE="http://www.junit.org/"

LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${NP}.zip
	cd ${S}
	rm junit.jar
	cp -a ${FILESDIR}/${PN}-${PV}-build.xml ${S}/build.xml
	unzip src.jar
	rm src.jar
}

src_compile() {
	ant || die
}

src_install() {
	dojar ${PN}${PV}/junit.jar ${PN}${PV}/src.jar ${PN}${PV}/junit/tests/test.jar
	dodir /usr/share/ant/lib
	dosym /usr/share/junit/lib/junit.jar /usr/share/ant/lib/
	dohtml -r README.html doc  javadoc
}
