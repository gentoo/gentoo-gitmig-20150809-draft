# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javolution/javolution-2.2.0.ebuild,v 1.1 2005/01/09 18:00:40 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="Java Solution for Real-Time and Embedded Systems"
SRC_URI="http://javolution.org/${P}-src.zip"
HOMEPAGE=""
LICENSE="LGPL-2.1"
SLOT="2.2"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jdk-1.4"
RESTRICT="nomirror"

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
	dodoc doc/coding_standard.txt doc/license.txt
	use doc && java-pkg_dohtml -r index.html api/*
}
