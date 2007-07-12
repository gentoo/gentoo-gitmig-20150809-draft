# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mindterm/mindterm-3.0.1.ebuild,v 1.7 2007/07/12 02:52:15 mr_bones_ Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/80_MindTerm/"
SRC_URI="http://www.appgate.com/products/80_MindTerm/110_MindTerm_Download/${P/-/_}-src.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples"
RDEPEND=">=virtual/jre-1.3"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	|| ( dev-java/ant-nodeps dev-java/ant-tasks )"
S=${WORKDIR}/${P/-/_}

src_compile() {
	ANT_TASKS="ant-nodeps" eant mindterm.jar lite $(use_doc doc)
}

src_install() {
	java-pkg_dojar *.jar

	java-pkg_dolauncher ${PN} --main com.mindbright.application.MindTerm

	dodoc README.txt || die
	use doc && java-pkg_dojavadoc javadoc
	use examples && java-pkg_doexamples "${S}/examples/"
}
