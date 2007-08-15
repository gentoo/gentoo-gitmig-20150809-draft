# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/istack-commons-runtime/istack-commons-runtime-20070122.ebuild,v 1.4 2007/08/15 10:46:06 opfer Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="istack-commons"
HOMEPAGE="https://istack-commons.dev.java.net/"
SRC_URI="mirror://gentoo/istack-commons-${PV}.tar.bz2"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/sun-jaf"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/istack-commons-${PV}"

src_unpack() {
	unpack ${A}

	java-ant_bsfix_one "${S}/build-common.xml"

	java-pkg_jarfrom --into "${S}/runtime/lib" sun-jaf
}

EANT_BUILD_XML="runtime/build.xml"

src_install() {

	java-pkg_dojar runtime/build/istack-commons-runtime.jar

	use source && java-pkg_dosrc runtime/src/*
}
