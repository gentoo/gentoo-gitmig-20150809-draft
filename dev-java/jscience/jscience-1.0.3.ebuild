# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jscience/jscience-1.0.3.ebuild,v 1.4 2005/07/15 22:26:07 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Tools and Libraries for the Advancement of Sciences"
SRC_URI="http://jscience.org/${P}-src.zip"
HOMEPAGE="http://jscience.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc jikes source"
RDEPEND=">=virtual/jre-1.3
	=dev-java/javolution-2.2*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	>=dev-java/ant-core-1.4
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"

S=${WORKDIR}/jscience-${PV%.*}

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from javolution-2.2
}

src_compile() {
	local antflags="jarfile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar jscience.jar
	dodoc doc/coding_standard.txt
	use doc && java-pkg_dohtml -r index.html api/*
	use source && java-pkg_dohtml ${S}/src/*
}
