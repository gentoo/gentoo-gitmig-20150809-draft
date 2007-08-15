# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr101/jsr101-1.1.ebuild,v 1.3 2007/08/15 10:30:17 opfer Exp $

JAVA_PKG_IUSE=""

inherit java-pkg-2

DESCRIPTION="Java(TM) API for XML-Based RPC Specification Interface Classes"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/first/jsr101/"
SRC_URI="jaxrpc-1_1-fr-spec-api.zip"

LICENSE="sun-bcla-jsr101"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

pkg_nofetch() {

	einfo "Please go to http://java.sun.com/xml/downloads/jaxrpc.html"
	einfo "and download file:"
	einfo ' "Java API for XML-Based RPC (JAX-RPC) JAR with API Class Files 1.1"'
	einfo "Place the file jaxrpc-1_1-fr-spec-api.zip in:"
	einfo " ${DISTDIR}"

}

src_compile() {
	:
}

src_install() {
	java-pkg_newjar "jaxrpc-1_1-fr-spec-api.jar" "jaxrpc-api.jar"
}
