# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jnlp-bin/jnlp-bin-1.2.ebuild,v 1.1 2004/09/21 19:33:58 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Network Launching Protocol (JNLP)"

HOMEPAGE="http://java.sun.com/products/javawebstart/download-jnlp.html"
SRC_URI="javaws-1_2-dev.zip"
LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#DEPEND=""
RDEPEND="virtual/jre"
RESTRICT="fetch"

S=${WORKDIR}

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7026-jaws_dev_pack-1.2-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${A} and place it in ${DISTDIR}"
	einfo "${DOWNLOAD_URL}"
}

src_compile() { :; }

src_install() {
	java-pkg_dojar *.jar
	dohtml -r .
}
