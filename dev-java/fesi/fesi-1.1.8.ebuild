# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-1.1.8.ebuild,v 1.6 2005/07/16 13:42:24 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="JavaScript Interpreter written in Java"
SRC_URI="mirror://gentoo/${P}.gentoo.tar.bz2"
HOMEPAGE="http://www.lugrin.ch/fesi"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc"
IUSE="doc examples jikes source"
RDEPEND=">=virtual/jre-1.3
	=dev-java/bsf-2.3*
	=dev-java/jakarta-oro-2.0*
	>=dev-java/javacc-3.2
	=dev-java/gnu-regexp-1.1*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/fesibuild.patch

	bf=build.properties
	cd ant/
	echo "javaccdir=$(java-pkg_getjars javacc)" > ${bf}
	echo "ororegexp=$(java-pkg_getjars jakarta-oro-2.0)" >> ${bf}
	echo "gnuregexp=$(java-pkg_getjars gnu-regexp-1)" >> ${bf}
	echo "bsfdir=$(java-pkg_getjars bsf-2.3)" >> ${bf}
}

src_compile() {
	cd ant/

	local antflags="jars"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	if use doc; then
		dodoc License.txt Readme.txt
		java-pkg_dohtml -r doc/html/*
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/FESI/*
}
