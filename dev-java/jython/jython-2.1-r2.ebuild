# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1-r2.ebuild,v 1.1 2004/01/17 16:03:14 strider Exp $

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="http://www.jython.org"
MY_PV="21"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
LICENSE="JPython"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=virtual/jdk-1.2"

src_unpack() {
	addwrite .hotspot
	cd ${DISTDIR}
	java ${PN}-${MY_PV} -o ${S}/ demo lib source

}

src_install() {
	dojar jython.jar
	dodoc {README,LICENSE}.txt NEWS ACKNOWLEDGMENTS
	dohtml -A .css .jpg .gif -r Doc
	dobin ${FILESDIR}/jython
	dobin ${FILESDIR}/jythonc

	cp -R Lib/* ${D}/usr/share/${PN}/lib/
	mkdir ${D}/usr/share/${PN}/tools/
	cp -R Tools/* ${D}/usr/share/${PN}/tools/
}
