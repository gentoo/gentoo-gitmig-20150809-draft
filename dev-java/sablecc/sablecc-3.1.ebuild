# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablecc/sablecc-3.1.ebuild,v 1.1 2006/01/16 01:24:07 nichoj Exp $

inherit java-pkg

DESCRIPTION="Java based compiler / parser generator"
HOMEPAGE="http://www.sablecc.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
# jikes disabled because of upstream recommendation
IUSE="source"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5.1
	source? ( app-arch/zip )"

src_compile() {
	local antflags="jar"
	ant ${antflags} || die "compile error"
}

src_install() {
	java-pkg_dojar lib/*

	dobin ${FILESDIR}/${PN}

	dodoc AUTHORS THANKS
	dohtml README.html
	use source && java-pkg_dosrc src/*
}
