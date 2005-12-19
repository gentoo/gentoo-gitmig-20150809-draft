# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cpptasks/cpptasks-1.0_beta3.ebuild,v 1.1 2005/12/19 04:21:05 nichoj Exp $

inherit java-pkg

MY_P="${PN}-${PV/_beta/b}"
DESCRIPTION="Ant-tasks to compile various source languages and produce executables, shared libraries and static libraries"
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	 >=dev-java/ant-core-1.5
	 dev-java/ant-contrib"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
}
src_compile() {
	local antflags="jars"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs -Dbuild.javadocs=build/api"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/

	dodoc NOTICE
	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc src/*
}
