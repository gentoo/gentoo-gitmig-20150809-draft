# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.5.0.ebuild,v 1.1 2004/02/07 05:06:10 strider Exp $

SRC_URI="j2sdk-1_5_0-beta-doc.zip"
DESCRIPTION="Javadoc for Java SDK version 1.5.0 Beta 1"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/download.jsp"
LICENSE="sun-j2sl"
SLOT="1.5.0"
KEYWORDS="~x86 ~amd64 -ppc -sparc -alpha -mips -hppa -arm"
DEPEND=">=app-arch/unzip-5.50-r1"
RESTRICT="fetch"

S="${WORKDIR}/docs"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
}

src_install(){
	dohtml index.html

	local dirs="api guide images relnotes tooldocs"
	for i in $dirs ; do
		cp -r $i ${D}/usr/share/doc/${P}/html
	done
}

