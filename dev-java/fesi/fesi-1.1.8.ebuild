# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-1.1.8.ebuild,v 1.1 2004/12/04 14:03:26 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="JavaScript Interpreter written in Java"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${P}.gentoo.tar.bz2"
HOMEPAGE="http://www.lugrin.ch/fesi"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86" #karltk: ~amd64 is missing bsf-2.3"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	=dev-java/bsf-2.3*
	=dev-java/oro-2.0*
	>=dev-java/javacc-3.2"
RDEPEND=">=virtual/jdk-1.3
	=dev-java/gnu-regexp-1.1*"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/fesibuild.patch

	bf=build.properties
	cd ant/
	echo "javaccdir=`java-config -p javacc`" > ${bf}
	echo "ororegexp=`java-config -p oro`" >> ${bf}
	echo "gnuregexp=`java-config -p gnu-regexp-1`" >> ${bf}
	echo "bsfdir=`java-config -p bsf-2.3`" >> ${bf}
}

src_compile() {
	cd ant/

	local antflags="jars"
	if use doc; then
		antflags="${antflags} docs"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/fesi.jar

	dodoc License.txt Readme.txt
	if use doc; then
		java-pkg_dohtml -r doc/html/*
	fi
}
