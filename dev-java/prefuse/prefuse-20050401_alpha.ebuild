# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/prefuse/prefuse-20050401_alpha.ebuild,v 1.1 2005/07/18 16:54:09 axxo Exp $

inherit java-pkg

DESCRIPTION="User interface toolkit for building highly interactive visualizations of structured and unstructured data."
SRC_URI="mirror://sourceforge/prefuse/${PN}-alpha-${PV/_alpha/}.zip"
HOMEPAGE="http://prefuse.sourceforge.net/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}-alpha-${PV/_alpha/}

src_unpack() {
	unpack ${A}
	cd ${S}

	cd lib/
	rm -f *.jar
}

src_compile() {
	local antflags="all"
	use doc && antflags="${antflags} api"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc readme.txt
	if use doc; then
		java-pkg_dohtml -r doc/api
	fi
}
