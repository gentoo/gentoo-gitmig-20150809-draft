# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/flute/flute-1.3.ebuild,v 1.5 2005/07/16 13:35:53 axxo Exp $

inherit java-pkg

DESCRIPTION="Flute is an implementation for SAC"
HOMEPAGE="http://www.w3.org/Style/CSS/SAC/"
SRC_URI="http://www.w3.org/2002/06/flutejava-${PV}.zip"

LICENSE="W3C"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	 dev-java/sac"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	app-arch/unzip
	jikes? ( dev-java/jikes )
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

	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compiling failed"
}

src_install() {
	java-pkg_dojar ${S}/dist/flute.jar

	use doc && java-pkg_dohtml -r ${S}/dist/doc/*
	use source && java-pkg_dosrc ${S}/src/*
}
