# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.2.2.006.ebuild,v 1.1 2004/07/16 12:04:27 axxo Exp $

At="jdk-1_2_2_006-doc.tar.gz"
S="${WORKDIR}/jdk1.2.2/docs"
SRC_URI="jdk-1_2_2_006-doc.tar.gz"
DESCRIPTION="Javadoc for Java SDK version 1.2.2"
HOMEPAGE="http://java.sun.com/products/archive/"
LICENSE="sun-j2sl"
SLOT="1.2"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7549-j2sdk-1.2.2_006-doc-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from"
	einfo "${DOWNLOAD_URL}"
	einfo "and move it to ${DISTDIR}"
}

src_install(){
	dohtml index.html

	# Copy each of the directories over.
	local dirs="api guide images relnotes tooldocs"
	for i in $dirs ; do
		cp -dPR $i ${D}/usr/share/doc/${P}/html
	done
}
