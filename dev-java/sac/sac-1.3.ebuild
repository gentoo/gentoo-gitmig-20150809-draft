# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sac/sac-1.3.ebuild,v 1.6 2005/07/15 16:56:57 axxo Exp $

inherit java-pkg

DESCRIPTION="SAC is a standard interface for CSS parser"
HOMEPAGE="http://www.w3.org/Style/CSS/SAC/"
SRC_URI="http://www.w3.org/2002/06/sacjava-${PV}.zip"

LICENSE="W3C"
SLOT="0"
KEYWORDS="amd64 x86 ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	jikes? ( dev-java/jikes )
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
	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compiling failed"
}

src_install() {
	java-pkg_dojar dist/sac.jar

	use doc && java-pkg_dohtml -r dist/doc/*
	use source && java-pkg_dosrc src/*
}
