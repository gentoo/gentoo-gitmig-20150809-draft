# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xindice/xindice-1.0-r4.ebuild,v 1.5 2008/09/11 06:56:03 pva Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A native java XML database"
HOMEPAGE="http://xml.apache.org/xindice"
SRC_URI="http://xml.apache.org/${PN}/dist/xml-${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

# breaks with XML apis of Java 1.5
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.3* )
	dev-java/ant-core"
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.3* )"

S=${WORKDIR}/xml-${P}

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 /bin/sh /var/run/${PN} ${PN}

	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-r3.patch
}

src_compile() {
	export XINDICE_HOME=${S}
	eant
}

src_install() {
	export TARGET=/opt/${PN}
	keepdir /var/run/${PN}
	chown ${PN}:${PN} "${D}"/var/run/${PN}
	dodir ${TARGET}
	dodir ${TARGET}/java
	cp -pPR bin config icons docs logs idl "${D}"${TARGET}
	cd java
	cp -pPR lib tests examples "${D}"${TARGET}/java
	cd ..
	dodoc docs/LICENSE docs/README docs/FAQ docs/TODO docs/VERSIONS docs/AUTHORS
	dohtml docs/AdministratorsGuide.html docs/DevelopersGuide.html docs/UsersGuide.html docs/ToolsReference.html docs/feather.gif docs/index.html docs/xindice.jpg
	doenvd "${FILESDIR}"/21${PN}
	newinitd "${FILESDIR}"/${PN}-r2 ${PN}
	insinto ${TARGET}
	doins start
	keepdir /opt/${PN}/db
	chown -R ${PN}:${PN} "${D}"/opt/${PN}
}
