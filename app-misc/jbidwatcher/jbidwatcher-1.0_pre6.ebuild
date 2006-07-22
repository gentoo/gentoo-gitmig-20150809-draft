# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-1.0_pre6.ebuild,v 1.2 2006/07/22 21:59:18 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PV=${PV/_/} # get rid of underscore between version and pre
MY_PN="JBidWatcher"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Java-based eBay bidding, sniping and tracking tool"
HOMEPAGE="http://www.jbidwatcher.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix bad build.xml (used to be the sed)
	epatch "${FILESDIR}/${P}-build_xml.patch"
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar ${MY_PN}-${MY_PV}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api

	java-pkg_dolauncher ${PN} --jar ${PN}.jar
	newicon jbidwatch64.jpg ${PN}.jpg
	make_desktop_entry ${PN} ${MY_PN}
}
