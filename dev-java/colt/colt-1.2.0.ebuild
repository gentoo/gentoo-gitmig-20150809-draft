# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/colt/colt-1.2.0.ebuild,v 1.3 2006/10/05 15:17:03 gustavoz Exp $

inherit java-pkg eutils

DESCRIPTION="Colt provides a set of Open Source Libraries for High Performance Scientific and Technical Computing in Java."
SRC_URI="http://dsd.lbl.gov/~hoschek/colt-download/releases/${P}.zip"
HOMEPAGE="http://www-itg.lbl.gov/~hoschek/colt/"
LICENSE="colt"
IUSE="doc jikes"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=virtual/jdk-1.4
		>=dev-java/concurrent-util-1.3.4
		dev-java/ant-core
		app-arch/unzip
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
		 >=dev-java/concurrent-util-1.3.4"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}-benchmark-no-deprecation.patch

	find ${S} -iname '*.jar' -exec rm \{\} \;

	cd ${S}/lib
	java-pkg_jar-from concurrent-util
}

src_compile() {
	local antflags="javac jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	dohtml README.html
	use doc && java-pkg_dohtml -r doc/*
}
