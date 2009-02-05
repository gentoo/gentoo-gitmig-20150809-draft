# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/omegat/omegat-1.8.1_p02.ebuild,v 1.1 2009/02/05 16:53:56 matsuu Exp $

EAPI=1
JAVA_PKG_BSFIX_NAME="build.xml build-impl.xml profiler-build-impl.xml"
inherit eutils java-pkg-2 java-ant-2

MY_P="OmegaT_${PV/_p/_}"
DESCRIPTION="Open source computer assisted translation (CAT) tool written in Java."
HOMEPAGE="http://www.omegat.org/"
SRC_URI="mirror://sourceforge/omegat/${MY_P}_Source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
RDEPEND=">=virtual/jre-1.4
	dev-java/backport-util-concurrent
	dev-java/swing-layout:1"
#	dev-java/jna
DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd "${S}/lib"
	java-pkg_jar-from backport-util-concurrent
	# java-pkg_jar-from htmlparser
	# java-pkg_jar-from jmyspell-core jmyspell-core.jar jmyspell-core-1.0.0-beta-2-1.4.jar
	# java-pkg_jar-from jna
	# java-pkg_jar-from MRJAdapter
	# java-pkg_jar-from retroweaver-rt retroweaver-rt.jar retroweaver-rt-2.0.1.jar
	java-pkg_jar-from swing-layout-1 swing-layout.jar swing-layout-1.0.jar
	# java-pkg_jar-from vldocking vldocking.jar vldocking_2.1.4.jar

	# cd "${S}/nbproject"
	# java-pkg_jar-from org-netbeans-modules-java-j2seproject-copylibstask.jar
}

src_install() {
	local myarch
	if use x86 ; then
		myarch=i386
	elif use amd64 ; then
		myarch=amd64
	fi

	java-pkg_dojar dist/*.jar
	dosym /usr/share/doc/${PF}/html "${JAVA_PKG_JARDEST}"/docs

	if [ -n "${myarch}" ] ; then
		libopts -m0755
		java-pkg_doso dist/native/libhunspell-${myarch}.so
		dosym "${JAVA_PKG_LIBDEST}" "${JAVA_PKG_JARDEST}"/native
	fi

	java-pkg_jarinto "${JAVA_PKG_JARDEST}"/lib
	java-pkg_dojar dist/lib/*.jar

	java-pkg_dolauncher ${PN} --jar OmegaT.jar

	dodoc release/changes.txt release/readme*.txt
	dohtml -A properties -r docs/*
	docinto lib; dodoc lib/*.txt

	doicon images/OmegaT.png
	make_desktop_entry ${PN} "OmegaT" "OmegaT" "Application;Office"
}
