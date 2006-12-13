# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.6.0.ebuild,v 1.1 2006/12/13 01:26:31 caster Exp $

SRC_URI="jdk-6-doc.zip"
DESCRIPTION="Documentation (including API Javadocs) for Java SDK version ${PV}"
HOMEPAGE="http://java.sun.com/javase/6/docs/"
LICENSE="sun-j2sl-6"
SLOT="1.6.0"
KEYWORDS="-alpha ~amd64 -hppa -mips -ppc -sparc ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="fetch"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jdk-6-doc-oth-JPR&SiteId=JSC&TransactionId=noreg"

S="${WORKDIR}/docs"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from "
	einfo "${DOWNLOAD_URL}"
	einfo "and place it in ${DISTDIR}"
#	einfo "and place it in ${DISTDIR} named as"
#	einfo "${SRC_URI}. Notice the ${PR}. Because Sun changes the doc zip file"
#	einfo "without changing the filename, we have to resort to renaming to keep"
#	einfo "the md5sum verification working existing and new downloads."
#	einfo ""
	einfo "If emerge fails because of a md5sum error it is possible that Sun"
	einfo "has again changed the upstream release, try downloading the file"
	einfo "again or a newer revision if available. Otherwise report this to"
	einfo "http://bugs.gentoo.org/67266 and we will make a new revision."
}

src_install(){
	insinto /usr/share/doc/${P}/html
	doins index.html

	for i in *; do
		[[ -d $i ]] && doins -r $i
	done
}
