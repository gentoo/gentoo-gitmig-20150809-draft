# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockmaker/mockmaker-1.12.0_p20050104.ebuild,v 1.2 2005/04/15 16:35:44 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Program for automatically creating source code for mock object."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://mockmaker.sourceforge.net"
LICENSE="MIT"
SLOT="1.12"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	~dev-java/qdox-20050104"
RDEPEND=">=virtual/jre-1.4"

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

	if use doc; then
		dodoc README.txt
		java-pkg_dohtml -r doc/*
	fi
}
