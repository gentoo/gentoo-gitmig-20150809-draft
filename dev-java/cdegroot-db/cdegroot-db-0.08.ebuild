# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cdegroot-db/cdegroot-db-0.08.ebuild,v 1.4 2005/04/03 08:54:25 sejo Exp $

inherit java-pkg eutils

DESCRIPTION="OO database written in Java"
HOMEPAGE="http://www.cdegroot.com/software/db/"
SRC_URI="http://www.cdegroot.com/software/db/download/com.${P/-/.}.tar.gz"

LICENSE="cdegroot"
SLOT="1"
KEYWORDS="~amd64 ~x86 ~ppc64 ~sparc ~ppc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/com.${P/-/.}

src_unpack() {
	unpack ${A}
	rm -rf ${S}/src/db/test

	cd ${S}
	cp ${FILESDIR}/build.xml ${S}/build.xml
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc TODO VERSION CHANGES BUGS README
	use doc && java-pkg_dohtml docs/*
}
