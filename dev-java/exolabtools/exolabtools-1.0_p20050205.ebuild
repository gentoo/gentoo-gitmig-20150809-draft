# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabtools/exolabtools-1.0_p20050205.ebuild,v 1.3 2005/03/23 17:54:53 gustavoz Exp $

inherit java-pkg

MY_P=${P/-1.0_p/-}

DESCRIPTION="Exolab Build Tools"
HOMEPAGE="http://cvs.sourceforge.net/viewcvs.py/openjms/tools/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="Exolab"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	dev-java/oro
	=dev-java/xerces-1.3*"

S=${WORKDIR}/${MY_P}

src_compile() {
	cd ${S}/src

	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	mv dist/${PN}-1.0.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r build/doc/*
}
