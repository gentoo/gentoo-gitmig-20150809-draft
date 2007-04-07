# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/browserlauncher2/browserlauncher2-1.0.ebuild,v 1.4 2007/04/07 16:47:50 josejx Exp $

inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV//.}"
MY_PN="BrowserLauncher2"

DESCRIPTION="BrowserLauncher2 is a library that facilitates opening a browser from a Java application"
HOMEPAGE="http://browserlaunch2.sourceforge.net/"
SRC_URI="mirror://sourceforge/browserlaunch2/${MY_PN}-all-${MY_PV}.jar"

LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fixing build.xml
	sed -i -e "s: includes=\"\*\*/\*\.class\"::g" build.xml
}

src_compile() {
	eant build $(use_doc api)
}

src_install() {
	java-pkg_dojar deployment/*.jar
	java-pkg_dolauncher BrowserLauncherTestApp-${SLOT} \
		--main "edu.stanford.ejalbert.testing.BrowserLauncherTestApp"

	dodoc README*
	use doc && java-pkg_dojavadoc api
	use source && java-pkg_dosrc source
}
