# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.5.0_rc.ebuild,v 1.1 2004/09/21 08:39:39 axxo Exp $

SRC_URI="jdk-1_5_0-rc-doc.zip"
DESCRIPTION="Javadoc for Java SDK version 1.5.0 Beta 2"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/"
LICENSE="sun-j2sl"
SLOT="1.5.0"
KEYWORDS="~x86 ~amd64 -ppc -sparc -alpha -mips -hppa"
IUSE=""
DEPEND=">=app-arch/unzip-5.50-r1"
RESTRICT="fetch"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jdk-1.5.0-rc-doc-oth-JPR&SiteId=JSC&TransactionId=noreg"

S="${WORKDIR}/docs"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${DOWNLOAD_URL} and move it to ${DISTDIR}"
}

src_install(){
	dohtml index.html

	local dirs="api guide images relnotes tooldocs"
	for i in $dirs ; do
		cp -r $i ${D}/usr/share/doc/${P}/html
	done
}
