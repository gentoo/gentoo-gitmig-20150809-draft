# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glassfish-persistence/glassfish-persistence-1.0.ebuild,v 1.4 2007/08/15 09:35:37 opfer Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Glassfish implementation of persistence API"
HOMEPAGE="https://glassfish.dev.java.net/"
SRC_URI="http://download.java.net/javaee5/fcs_branch/promoted/source/glassfish-9_0-b48-src.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/jdk-1.5
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

MODULE="persistence-api"
S="${WORKDIR}/glassfish"

src_compile() {
	cd ${S}/${MODULE}
	eant all
}

src_install() {
	cd ${WORKDIR}/publish/glassfish
	java-pkg_newjar lib/javaee.jar

	dodir /usr/share/${PN}/lib/schemas
	cp lib/schemas/*.xsd ${D}/usr/share/${PN}/lib/schemas
}
