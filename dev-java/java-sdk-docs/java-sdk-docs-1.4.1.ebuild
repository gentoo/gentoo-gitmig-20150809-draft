# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.4.1.ebuild,v 1.13 2004/02/15 09:44:26 darkspecter Exp $

At="j2sdk-1_4_1-doc.zip"
S="${WORKDIR}/docs"
SRC_URI="j2sdk-1_4_1-doc.zip"
DESCRIPTION="Javadoc for Java SDK version 1.4.1"
HOMEPAGE="http://java.sun.com/j2se/1.4.1/download.html"
LICENSE="sun-j2sl"
SLOT="1.4.1"
KEYWORDS="x86 ppc sparc -alpha amd64"
DEPEND=">=app-arch/unzip-5.50-r1"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and move it to ${DISTDIR}"
}

src_unpack() {
	unpack ${At} || die "Failed Unpacking"
}

src_install(){
	dohtml index.html

	local dirs="api guide images relnotes tooldocs"

	for i in $dirs ; do
		cp -a $i ${D}/usr/share/doc/${P}/html
	done
}
