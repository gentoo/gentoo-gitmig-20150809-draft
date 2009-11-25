# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proguard/proguard-4.3.ebuild,v 1.3 2009/11/25 09:56:31 maekke Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Free Java class file shrinker, optimizer, and obfuscator."
HOMEPAGE="http://proguard.sourceforge.net/"
MY_P=${P/-/}
MY_P=${MY_P/_/}
SRC_URI="mirror://sourceforge/proguard/${MY_P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples j2me"

DEPEND=">=virtual/jdk-1.4
		j2me? ( dev-java/sun-j2me-bin )
		dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
		j2me? ( dev-java/sun-j2me-bin )
		dev-java/ant-core"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	find "${S}" -name "*.jar" | xargs rm -v
}

src_compile() {
	# create jars
	mkdir dist

	einfo "Compiling ${PN}.jar"
	mkdir -p build/proguard/classes
	ejavac -sourcepath src -d build/proguard/classes src/proguard/ProGuard.java || die "Cannot compile 'proguard'"
	jar -cf "${S}"/dist/${PN}.jar -C build/proguard/classes proguard || die "Cannot create ${PN}.jar"

	einfo "Compiling ${PN}gui.jar"
	mkdir -p build/proguardgui/classes
	ejavac -sourcepath src -d build/proguardgui/classes src/proguard/gui/ProGuardGUI.java || die "Cannot compile 'proguardgui'"
	cp src/proguard/gui/*.gif build/proguardgui/classes/proguard/gui/
	cp src/proguard/gui/*.pro build/proguardgui/classes/proguard/gui/
	cp src/proguard/gui/*.properties build/proguardgui/classes/proguard/gui/
	jar -cf "${S}"/dist/${PN}gui.jar -C build/proguardgui/classes proguard || die "Cannot create ${PN}gui.jar"

	einfo "Compiling retrace.jar"
	mkdir -p build/retrace/classes
	ejavac -sourcepath src -d build/retrace/classes src/proguard/retrace/ReTrace.java || die "Cannot compile 'retrace'"
	jar -cf "${S}"/dist/retrace.jar -C build/retrace/classes proguard || die "Cannot create retrace.jar"

	einfo "Compiling ${PN}-ant.jar"
	mkdir -p build/ant/classes
	ejavac -sourcepath src -classpath $(java-pkg_getjars ant-core) \
		-d build/ant/classes src/proguard/ant/ProGuardTask.java || die "Cannot compile 'proguard-ant'"
	jar -cf "${S}"/dist/${PN}-ant.jar -C build/ant/classes proguard || die "Cannot create ${PN}-ant.jar"

	if use j2me ; then
		einfo "Compiling ${PN}-wtk.jar"
		mkdir -p build/wtk/classes
		ejavac -sourcepath src -classpath $(java-pkg_getjars sun-j2me-bin) \
			-d build/wtk/classes src/proguard/wtk/ProGuardObfuscator.java || die "Cannot compile 'proguard-wtk'"
		jar -cf "${S}"/dist/${PN}-wtk.jar -C build/wtk/classes proguard || die "Cannot create ${PN}-wtk.jar"
	fi

	# generate javadoc
	if use doc ; then
		mkdir javadoc
		local cp=$(java-pkg_getjars ant-core)
		use j2me && cp="${cp}:$(java-pkg_getjars sun-j2me-bin)"
		javadoc -d javadoc -sourcepath src -classpath $${cp} -subpackages proguard || die "Cannot compile javadoc"
	fi
}

src_install() {
	java-pkg_dojar dist/*
	java-pkg_dolauncher ${PN} --main proguard.ProGuard
	java-pkg_dolauncher ${PN}gui --main proguard.gui.ProGuardGUI
	java-pkg_dolauncher ${PN}_retrace --main proguard.retrace.ReTrace

	if use doc; then
		dohtml -r docs/*
		java-pkg_dojavadoc javadoc
	fi

	if use examples; then
		dohtml -r examples
	fi
}

pkg_postinst() {
	elog "Please see http://proguard.sourceforge.net/GPL_exception.html"
	elog "for linking exception information about ${PN}"
}
