# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/flute/flute-1.3-r1.ebuild,v 1.2 2006/12/09 09:16:49 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Flute is an implementation for SAC"
HOMEPAGE="http://www.w3.org/Style/CSS/SAC/"
SRC_URI="http://www.w3.org/2002/06/flutejava-${PV}.zip"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc source"

COMMON_DEP="dev-java/sac"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cp ${FILESDIR}/build.xml ${S}

	cd ${S}
	rm -f flute.jar

	mkdir src
	mv org src
}

src_compile() {
	echo "classpath=$(java-pkg_getjars sac)" > ${S}/build.properties
	eant
}

src_install() {
	java-pkg_dojar ${S}/dist/flute.jar

	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc ${S}/src/*
}
