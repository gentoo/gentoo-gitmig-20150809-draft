# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/jxplorer/jxplorer-3.1_rc4.ebuild,v 1.3 2005/07/18 22:23:36 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="A fully functional ldap browser written in java."
HOMEPAGE="http://jxplorer.org/"
SRC_URI="mirror://sourceforge/${PN}/JXv${PV/_/}src.tar.bz2
	mirror://sourceforge/${PN}/JXv${PV/_/}deploy.tar.bz2"
LICENSE="CAOSL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/commons-discovery-0.2
	>=dev-java/commons-logging-1.0.4
	>=dev-java/dom4j-1.4
	>=dev-java/javahelp-bin-2.0.01
	>=dev-java/log4j-1.2.8
	>=dev-java/sun-dsml-bin-2.1.2_pre1
	>=dev-java/sun-jaf-bin-1.0.2
	>=dev-java/sun-javamail-bin-1.3.1
	=www-servers/axis-1*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml ./build.xml

	epatch ${FILESDIR}/jxplorer-log4j.patch
	epatch ${FILESDIR}/jxplorer-gentoo.patch

	mkdir lib/ && cd lib/
	java-pkg_jar-from javahelp-bin
}

src_compile() {
	# jikes build not possible atm
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar jars/help.jar

	dodir /usr/share/${PN}
	for i in "icons images htmldocs language templates security connections.txt log4j.xml"
	do
		cp -r ${i} ${D}/usr/share/${PN}
	done

	newbin ${FILESDIR}/jxplorer.sh jxplorer
}
