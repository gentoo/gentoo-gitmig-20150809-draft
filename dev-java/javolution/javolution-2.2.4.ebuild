# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javolution/javolution-2.2.4.ebuild,v 1.2 2005/07/15 22:22:33 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Java Solution for Real-Time and Embedded Systems"
SRC_URI="http://javolution.org/${P}-src.zip"
HOMEPAGE="http://javolution.org"
LICENSE="LGPL-2.1"
SLOT="2.2.4"
KEYWORDS="~amd64 x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	app-arch/unzip
	source? ( app-arch/zip )"
	#jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/javolution-${PV%.*}

src_compile() {
	antflags="init_1.4 compile jar"
	use doc && antflags="${antflags} doc"
	# disabled jikes for now till i've the time to write an patch for this
	#use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar javolution.jar
	dodoc doc/coding_standard.txt
	use doc && java-pkg_dohtml -r index.html api/*
	use source && java-pkg_dosrc ${S}/src/javolution
}
