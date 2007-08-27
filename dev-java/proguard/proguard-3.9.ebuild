# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proguard/proguard-3.9.ebuild,v 1.1 2007/08/27 10:47:47 betelgeuse Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Free Java class file shrinker, optimizer, and obfuscator."
HOMEPAGE="http://proguard.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/sun-j2me-bin
	dev-java/ant-core"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}
	cp -i "${FILESDIR}/build.xml" "${S}"
	rm -v "${S}"/lib/*.jar || die
	cd "${S}" && java-ant_rewrite-classpath
}

EANT_DOC_TARGET=""
EANT_BUILD_TARGET="proguard"
EANT_GENTOO_CLASSPATH="sun-j2me-bin,ant-core"

src_install() {
	java-pkg_dojar dist/*
	java-pkg_dolauncher ${PN} --main proguard.ProGuard
	java-pkg_dolauncher ${PN}gui --main proguard.gui.ProGuardGUI
	java-pkg_dolauncher ${PN}_retrace --main proguard.retrace.ReTrace

	java-pkg_register-ant-task

	use doc && dohtml -r docs/*
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc src/*
}

pkg_postinst() {
	elog "Please see http://proguard.sourceforge.net/GPL_exception.html"
	elog "for linking exception information about ${PN}"
}
