# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockmaker/mockmaker-1.12.0_p20050104.ebuild,v 1.4 2005/07/15 20:43:42 axxo Exp $

inherit java-pkg

DESCRIPTION="Program for automatically creating source code for mock object."
HOMEPAGE="http://mockmaker.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
SLOT="1.12"
KEYWORDS="x86 amd64 ppc"
IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.4
	~dev-java/qdox-20050104"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	# we keep mmmockobjects.jar since it's used for bootstrapping
	java-pkg_jar-from qdox-1.6
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/tmp/${PN}.jar

	dodoc README.txt
	use doc && java-pkg_dohtml -r doc/*
}
