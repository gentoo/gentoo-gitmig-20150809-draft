# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javolution/javolution-1.1.0.ebuild,v 1.1 2004/11/14 13:48:21 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Solution for Real-Time and Embedded Systems"
SRC_URI="http://javolution.org/${P}-src.zip"
HOMEPAGE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/javolution-${PV%.*}

src_compile() {
	antflags="compile jarfile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar javolution.jar
	dodoc doc/coding_standard.txt doc/license.txt
	use doc && java-pkg_dohtml -r index.html api/*
}
