# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablecc/sablecc-2.18.2.ebuild,v 1.7 2004/10/22 10:10:07 absinthe Exp $

inherit java-pkg

DESCRIPTION="Java based compiler / parser generator"
HOMEPAGE="http://www.sablecc.org/"
SRC_URI="mirror://sourceforge/sablecc/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/java-getopt-1.0.9
	>=dev-java/ant-1.5.1
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jre-1.4"

src_compile () {
	local antflags="jar"
	if use jikes ; then
		:; # Do nothing, jikes is enable by default
	else
		antflags="${antflags} -Dbuild.compiler=modern"
	fi
	ant ${antflags} || die "compile error"
}

src_install () {
	java-pkg_dojar lib/*

	dobin ${FILESDIR}/${PN}

	dodoc AUTHORS LICENSE THANKS
	dohtml README.html
}
