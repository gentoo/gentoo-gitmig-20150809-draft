# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr101/jsr101-1.1.ebuild,v 1.5 2007/12/05 19:59:50 nelchael Exp $

JAVA_PKG_IUSE=""

inherit java-pkg-2

DESCRIPTION="Java(TM) API for XML-Based RPC Specification Interface Classes"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/first/jsr101/"
SRC_URI="jaxrpc-1_1-fr-spec-api.zip"

LICENSE="sun-bcla-jsr101"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

pkg_nofetch() {

	einfo "Please go to:"
	einfo ' http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7935-jax_rpc-1.1-fr-class-oth-JSpec&SiteId=JSC&TransactionId=noreg'
	einfo "and download file:"
	einfo " ${SRC_URI}"
	einfo "and place it in:"
	einfo " ${DISTDIR}"

}

src_compile() {
	:
}

src_install() {
	java-pkg_newjar "jaxrpc-1_1-fr-spec-api.jar" "jaxrpc-api.jar"
}
