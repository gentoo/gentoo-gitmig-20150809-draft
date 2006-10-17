# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/henplus/henplus-0.9.7.ebuild,v 1.1 2006/10/17 21:47:39 caster Exp $

inherit java-pkg-2 eutils

DESCRIPTION="Java-based multisession SQL shell for databases with JDBC support."
HOMEPAGE="http://${PN}.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

COMMON_DEPEND="=dev-java/commons-cli-1*
	dev-java/libreadline-java"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEPEND}"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-build.xml.patch"

	cd lib
	rm -v *.jar build/*.jar
	java-pkg_jar-from commons-cli-1 commons-cli.jar
	java-pkg_jar-from libreadline-java libreadline-java.jar
}

src_compile() {
	eant jar $(use_doc)
}

src_install () {
	java-pkg_dojar "build/${PN}.jar"

	java-pkg_dolauncher ${PN} -pre "${FILESDIR}/${PN}.pre" \
		--main henplus.HenPlus

	dodoc README
	dohtml doc/HenPlus.html
	use doc && java-pkg_dojavadoc javadoc/api

	use source && java-pkg_dosrc "src/${PN}"
}

