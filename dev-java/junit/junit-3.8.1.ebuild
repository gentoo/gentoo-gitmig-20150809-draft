# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junit/junit-3.8.1.ebuild,v 1.9 2004/01/17 06:12:11 strider Exp $

NP=${P/-/}
S=${WORKDIR}/${NP}
DESCRIPTION="Simple framework to write repeatable tests"
SRC_URI="mirror://sourceforge/${PN}/${NP}.zip"
HOMEPAGE="http://www.junit.org/"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="x86 ppc sparc"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.3"
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd ${S}
	unzip src.jar
}

src_compile() {
	rm junit.jar
	ant || die
}

src_install() {
	cd ${NP}
	dojar junit.jar
	dodir /usr/share/ant/lib
	dosym /usr/share/junit/lib/junit.jar /usr/share/ant/lib/
	dohtml -r README.html cpl-v10.html doc javadoc
	cp javadoc/package-list ${D}/usr/share/doc/${PN}-${PV}/html/javadoc/package-list
}
