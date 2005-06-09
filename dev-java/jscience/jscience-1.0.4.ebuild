# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jscience/jscience-1.0.4.ebuild,v 1.2 2005/06/09 00:50:41 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="Java Tools and Libraries for the Advancement of Sciences"
SRC_URI="http://jscience.org/${P}-src.zip"
HOMEPAGE="http://jscience.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.3
	~dev-java/javolution-2.2.4"

S=${WORKDIR}/jscience-${PV%.*}

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from javolution-2.2.4
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
