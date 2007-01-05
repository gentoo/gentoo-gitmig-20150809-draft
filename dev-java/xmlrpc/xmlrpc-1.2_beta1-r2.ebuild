# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlrpc/xmlrpc-1.2_beta1-r2.ebuild,v 1.2 2007/01/05 23:44:09 caster Exp $

inherit java-pkg-2 java-ant-2

MY_PV=${PV/_beta/-b}

DESCRIPTION="Apache XML-RPC is a Java implementation of XML-RPC"
HOMEPAGE="http://ws.apache.org/xmlrpc/"
SRC_URI="http://www.apache.org/dist/ws/xmlrpc/v${MY_PV}/${PN}-${MY_PV}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local antflags="jar -Dbuild.dir=build -Dbuild.dest=dest -Dsrc.dir=src \
		-Djavadoc.destdir=api -Dfinal.name=xmlrpc-${MY_PV}"
	use doc && antflags="${antflags} javadocs"
	eant ${antflags} || die
}

src_install() {
	java-pkg_newjar build/xmlrpc-${MY_PV}.jar ${PN}.jar
	java-pkg_newjar build/xmlrpc-${MY_PV}-applet.jar ${PN}-applet.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r api
}

pkg_postinst() {
	elog "This port does not build Servlet and/or SSL extensions. This port"
	elog "does not provide examples examples either. Refer to README.txt for"
	elog "more details on this."
}
