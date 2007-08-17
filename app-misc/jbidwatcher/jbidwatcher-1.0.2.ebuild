# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jbidwatcher/jbidwatcher-1.0.2.ebuild,v 1.1 2007/08/17 17:21:03 caster Exp $

JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2 eutils

MY_PN="JBidWatcher"

DESCRIPTION="Java-based eBay bidding, sniping and tracking tool"
HOMEPAGE="http://www.jbidwatcher.com/"
SRC_URI="http://www.jbidwatcher.com/download/${P}.tar.gz"
#not this version at this time
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-javadoc.patch"
	use doc && mkdir -p docs/api
	# jdictrayapi and tritonus are here
	#rm -fr org
	# apple stuff and pat stuff
	#rm -rf com
	#rm -fr javazoom
}

src_compile() {
	eant -Duser.home="${T}" jar $(use_doc -Djavadoc.dir=docs/api javadoc)
}

src_install() {
	java-pkg_newjar ${MY_PN}-${PV}.jar

	use doc && java-pkg_dojavadoc docs/api

	java-pkg_dolauncher ${PN} --jar ${PN}.jar --java-args "-Xmx512m"
	newicon jbidwatch64.jpg ${PN}.jpg
	make_desktop_entry ${PN} ${MY_PN} ${PN}.jpg
}
