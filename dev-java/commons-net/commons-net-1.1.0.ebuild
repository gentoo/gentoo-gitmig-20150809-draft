# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.1.0.ebuild,v 1.2 2004/03/01 04:39:47 zx Exp $

inherit eutils java-pkg

S="${WORKDIR}/${P}"
DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/index.html"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.5.4
		>=dev-java/oro-2.0.7"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="jikes"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo.diff
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "died on ant"
}

src_install() {
	java-pkg_dojar target/*.jar || die "died on java-pkg_dojar"
}
