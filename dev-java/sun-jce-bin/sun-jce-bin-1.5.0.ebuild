# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jce-bin/sun-jce-bin-1.5.0.ebuild,v 1.6 2007/10/12 00:32:21 wltjr Exp $

jcefile="jce_policy-1_5_0.zip"

S="${WORKDIR}/jdk${MY_PVL}"
DESCRIPTION="Sun's J2SE Cryptographic extensions, version ${PV}"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/"
SRC_URI="${jcefile}"
SLOT="1.5"
LICENSE="sun-bcla-java-vm"
KEYWORDS="amd64 x86 ~x86-fbsd"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

FETCH_JCE="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=jce_policy-1.5.0-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${jcefile} from:"
	einfo ${FETCH_JCE}
	einfo "Java(TM) Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${jcefile} ]; then
		die "cannot read ${jcefile}. Please check the permission and try again."
	fi
}

src_install() {

	dodir /opt/${P}/jre/lib/security

	cd "${D}"/opt/${P}/jre/lib/security
	unzip ${DISTDIR}/${jcefile} || die "failed to unzip jce"
	mv jce unlimited-jce
	dodir /opt/${P}/jre/lib/security/strong-jce
}
