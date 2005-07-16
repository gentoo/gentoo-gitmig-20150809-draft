# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcalendar/jcalendar-1.2.2.ebuild,v 1.4 2005/07/16 10:36:59 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Java date chooser bean for graphically picking a date."
SRC_URI="http://www.toedter.com/download/${PN}.zip"
HOMEPAGE="http://www.toedter.com/en/jcalendar/"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes"
RDEPEND=">=virtual/jdk-1.4
	=dev-java/jgoodies-looks-1.2*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	rm -f *.jar
	java-pkg_jar-from jgoodies-looks-1.2 looks.jar looks-1.2.2.jar
}

src_compile() {
	cd src/

	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/jcalendar.jar

	dodoc readme.txt
	use doc && java-pkg_dohtml -r doc/*
}
