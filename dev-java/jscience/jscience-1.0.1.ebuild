# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jscience/jscience-1.0.1.ebuild,v 1.1 2004/11/14 13:49:04 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Tools and Libraries for the Advancement of Sciences"
SRC_URI="http://jscience.org/${P}-src.zip"
HOMEPAGE="http://jscience.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	>=dev-java/javolution-1.1.0
	>=app-arch/unzip-5.50-r1
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/jscience-${PV%.*}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	rm -f *.jar
	java-pkg_jar-from javolution
}

src_compile() {
	antflags="compile jarfile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar jscience.jar
	dodoc doc/coding_standard.txt doc/license.txt
	use doc && java-pkg_dohtml -r index.html api/*
}
