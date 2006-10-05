# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.4.1.ebuild,v 1.20 2006/10/05 17:21:26 gustavoz Exp $

At="j2sdk-1_4_1-doc.zip"
SRC_URI="j2sdk-1_4_1-doc.zip"
DESCRIPTION="Javadoc for Java SDK version 1.4.1"
HOMEPAGE="http://java.sun.com/products/archive/j2se/1.4.1_07/index.html"
LICENSE="sun-j2sl"
SLOT="1.4.1"
KEYWORDS="x86 ppc -alpha amd64 ppc64"
IUSE=""
DEPEND=">=app-arch/unzip-5.50-r1"
RESTRICT="fetch"

S="${WORKDIR}/docs"

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
