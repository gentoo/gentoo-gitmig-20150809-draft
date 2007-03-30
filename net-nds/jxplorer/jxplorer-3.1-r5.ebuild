# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/jxplorer/jxplorer-3.1-r5.ebuild,v 1.1 2007/03/30 13:41:36 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A fully functional ldap browser written in java."
HOMEPAGE="http://jxplorer.org/"
SRC_URI="mirror://sourceforge/${PN}/JXv${PV}src.tar.bz2
	mirror://sourceforge/${PN}/JXv${PV}deploy.tar.bz2"
LICENSE="CAOSL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/javahelp-2.0.02_p46
	>=dev-java/log4j-1.2.8
	dev-java/junit"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp "${FILESDIR}/build.xml" ./build.xml || die

	epatch "${FILESDIR}/jxplorer-gentoo.patch"

	# Contains stuff for javahelp
	mkdir dist
	cp jars/help.jar dist || die

	rm -v jars/*.jar jars/dsml/*.jar || die
	mkdir lib/ && cd lib/
	java-pkg_jar-from javahelp
	java-pkg_jar-from log4j
	java-pkg_jar-from junit
}

EANT_DOC_TARGET="docs"
EANT_FILTER_COMPILER="jikes"

src_install() {
	java-pkg_dojar dist/${PN}.jar dist/help.jar

	dodir /usr/share/${PN}
	for i in "icons images htmldocs language templates security connections.txt log4j.xml"
	do
		cp -r ${i} "${D}/usr/share/${PN}" || die
	done

	dodoc RELEASE.TXT || die

	java-pkg_dolauncher ${PN} \
		--main com.ca.directory.jxplorer.JXplorer \
		--pwd '"${HOME}/.jxplorer"' \
		--pkg_args console \
		-pre "${FILESDIR}/${PN}-pre-r1"

	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadocs docs
}
