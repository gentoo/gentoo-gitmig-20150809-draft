# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabcore/exolabcore-0.3.7_p20050205.ebuild,v 1.2 2005/03/23 17:55:50 gustavoz Exp $

inherit eutils java-pkg

MY_P=${P/-0.3.7_p/-}

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
	dev-java/cdegroot-db
	dev-java/commons-cli
	dev-java/commons-logging
	dev-java/exolabtools
	dev-java/log4j
	dev-java/oro
	=dev-java/xerces-1.3*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}/src
	epatch ${FILESDIR}/${P}-buildfile.patch

	cd ${S}/lib
	java-pkg_jar-from cdegroot-db-1
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from commons-logging
	java-pkg_jar-from exolabtools
	java-pkg_jar-from log4j
	java-pkg_jar-from oro
	java-pkg_jar-from xerces-1.3
}

src_compile() {
	cd ${S}/src

	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	mv dist/${PN}-0.3.7.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r build/doc/*
}
