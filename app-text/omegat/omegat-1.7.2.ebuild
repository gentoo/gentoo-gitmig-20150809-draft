# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/omegat/omegat-1.7.2.ebuild,v 1.1 2007/09/24 02:20:17 matsuu Exp $

JAVA_PKG_BSFIX_NAME="build.xml build-impl.xml profiler-build-impl.xml"
inherit eutils java-pkg-2 java-ant-2

MY_PV=${PV/_p/_}
DESCRIPTION="Open source computer assisted translation (CAT) tool written in Java."
HOMEPAGE="http://www.omegat.org/"
SRC_URI="mirror://sourceforge/omegat/OmegaT_${MY_PV}_Source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}"

src_install() {
	java-pkg_dojar dist/*.jar
	dosym /usr/share/doc/${PF}/html "${JAVA_PKG_JARDEST}"/docs

	java-pkg_jarinto "${JAVA_PKG_JARDEST}"/lib
	java-pkg_dojar dist/lib/*.jar

	java-pkg_dolauncher ${PN} --jar OmegaT.jar

	dodoc release/changes.txt release/readme*.txt
	dohtml -A properties -r docs/*
	docinto lib; dodoc lib/*.txt

	doicon images/OmegaT.png
	make_desktop_entry ${PN} "OmegaT" "OmegaT.png" "Application;Office"
}
