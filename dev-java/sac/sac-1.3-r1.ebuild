# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sac/sac-1.3-r1.ebuild,v 1.2 2006/12/09 09:24:20 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="SAC is a standard interface for CSS parser"
HOMEPAGE="http://www.w3.org/Style/CSS/SAC/"
SRC_URI="http://www.w3.org/2002/06/sacjava-${PV}.zip"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}

	cp ${FILESDIR}/build.xml ${S}

	cd ${S}
	rm -rf sac.jar META-INF/

	mkdir src
	mv org src
}

src_compile() {
	eant || die "Compiling failed"
}

src_install() {
	java-pkg_dojar dist/sac.jar

	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/*
}
