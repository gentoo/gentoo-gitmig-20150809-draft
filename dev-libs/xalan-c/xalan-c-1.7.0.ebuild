# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xalan-c/xalan-c-1.7.0.ebuild,v 1.3 2004/03/14 12:28:58 mr_bones_ Exp $

MY_PV=${PV//./_}
DESCRIPTION="XSLT processor for transforming XML into HTML, text, or other XML types"
HOMEPAGE="http://xml.apache.org/xalan-c/"
SRC_URI="ftp://apache.mirrors.pair.com/xml/xalan-c/Xalan-C_${MY_PV}-src.tar.gz
	http://apache.mirrors.hoobly.com/xml/xalan-c/Xalan-C_${MY_PV}-src.tar.gz
	http://www.tux.org/pub/net/apache/dist/xml/xalan-c/Xalan-C_${MY_PV}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-libs/xerces-c-2.4.0"

S=${WORKDIR}/xml-xalan/c

src_compile() {
	export XALANCROOT=${S}
	export XERCESCROOT="/usr/include/xercesc"
	./runConfigure -p linux -c gcc -x c++ -P /usr || die
	emake -j1 || die
}

src_install() {
	export XALANCROOT=${S}
	make DESTDIR=${D} install || die

	if use doc ; then
		dodir /usr/share/doc/${P}
		cp -r ${S}/samples ${D}/usr/share/doc/${PF}
		find ${D}/usr/share/doc/${PF} -type d -name CVS -exec rm -rf '{}' \; >& /dev/null
		dohtml -r doc/html
	fi

	dodoc README version.incl
	dohtml readme.html
}
