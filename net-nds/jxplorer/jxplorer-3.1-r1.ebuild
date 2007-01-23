# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/jxplorer/jxplorer-3.1-r1.ebuild,v 1.4 2007/01/23 10:28:39 beandog Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A fully functional ldap browser written in java."
HOMEPAGE="http://jxplorer.org/"
SRC_URI="mirror://sourceforge/${PN}/JXv${PV}src.tar.bz2
	mirror://sourceforge/${PN}/JXv${PV}deploy.tar.bz2"
LICENSE="CAOSL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc source"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/javahelp-bin-2.0.01
	>=dev-java/log4j-1.2.8
	dev-java/junit"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml ./build.xml

	epatch ${FILESDIR}/jxplorer-gentoo.patch

	# Contains stuff for javahelp
	mkdir dist
	cp jars/help.jar dist || die

	rm -v jars/*.jar jars/dsml/*.jar
	mkdir lib/ && cd lib/
	java-pkg_jar-from javahelp-bin
	java-pkg_jar-from log4j
	java-pkg_jar-from junit
}

#TODO: filter jikes when the general src_compile can do it
EANT_DOC_TARGET="docs"
EANT_FILTER_COMPILER="jikes"

src_install() {
	java-pkg_dojar dist/${PN}.jar dist/help.jar

	dodir /usr/share/${PN}
	for i in "icons images htmldocs language templates security connections.txt log4j.xml"
	do
		cp -r ${i} ${D}/usr/share/${PN}
	done

	dodoc RELEASE.TXT || die

	java-pkg_dolauncher ${PN} \
		--main com.ca.directory.jxplorer.JXplorer \
		--pwd '${HOME}/.jxplorer/' \
		--pkg_args console \
		-pre "${FILESDIR}/${PN}-pre"

	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadocs docs
}
