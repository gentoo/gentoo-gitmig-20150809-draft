# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jce-bin/sun-jce-bin-1.6.0.ebuild,v 1.4 2008/06/15 20:50:15 serkan Exp $

jcefile="jce_policy-6.zip"

DESCRIPTION="Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files ${PV}"
HOMEPAGE="http://java.sun.com/javase/6/"
SRC_URI="${jcefile}"
SLOT="1.6"
LICENSE="sun-bcla-java-vm"
KEYWORDS="amd64 x86 ~x86-fbsd"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/jce"

FETCH_JCE="https://cds.sun.com/is-bin/INTERSHOP.enfinity/WFS/CDS-CDS_Developer-Site/en_US/-/USD/ViewProductDetail-Start?ProductRef=jce_policy-6-oth-JPR@CDS-CDS_Developer"

pkg_nofetch() {
	einfo "Please download ${jcefile} from:"
	einfo ${FETCH_JCE}
	einfo "(JCE Unlimited Strength Jurisdiction Policy Files 6)"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r "${DISTDIR}"/${jcefile} ]; then
		die "cannot read ${jcefile}. Please check the permission and try again."
	fi

	unpack ${A}
}

src_install() {
	dodir /opt/${P}/jre/lib/security/unlimited-jce

	insinto /opt/${P}/jre/lib/security/unlimited-jce
	doins *.jar
	dodoc README.txt
	dohtml COPYRIGHT.html
}
