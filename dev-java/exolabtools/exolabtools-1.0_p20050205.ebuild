# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabtools/exolabtools-1.0_p20050205.ebuild,v 1.12 2006/10/05 15:40:19 gustavoz Exp $

inherit java-pkg

MY_P=${P/-1.0_p/-}

DESCRIPTION="Exolab Build Tools"
HOMEPAGE="http://openjms.cvs.sourceforge.net/openjms/tools/src/main/org/exolab/tools/ant/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="Exolab"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/jakarta-oro-2.0*
	=dev-java/xerces-1.3*"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	cd "${S}/src/etc"
	mv JARS JARS.upstream
	echo "project.jar.oro=jakarta-oro.jar" > JARS

	cd "${S}/lib"
	java-pkg_jar-from jakarta-oro-2.0
}

src_compile() {
	cd "${S}/src"
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_newjar dist/${PN}-1.0.jar ${PN}.jar

	if use doc; then
		dodoc src/etc/CHANGELOG src/etc/VERSION

		# TODO when package freeze is over make this install to
		# html/api
		java-pkg_dohtml -r build/doc/*
	fi

	use source && java-pkg_dosrc src/main/*
}
