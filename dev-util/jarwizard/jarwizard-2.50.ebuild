# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jarwizard/jarwizard-2.50.ebuild,v 1.1 2007/04/01 13:17:49 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Takes the hassle out of creating executable JAR files for your Java programs"
SRC_URI="mirror://sourceforge/jarwizard/${PN}_${PV/./}_src.zip"
HOMEPAGE="http://www.geocities.com/chir_geo/jarc/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc"
DEPEND=">=virtual/jdk-1.5
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	java-ant_bsfix_one "${S}/nbproject/build-impl.xml"
}

src_install() {
	java-pkg_dojar dist/*.jar
	java-pkg_dolauncher ${PN} --main JarWizard
}
