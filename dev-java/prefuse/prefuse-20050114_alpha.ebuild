# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/prefuse/prefuse-20050114_alpha.ebuild,v 1.1 2005/01/21 21:07:11 luckyduck Exp $

inherit java-pkg

DESCRIPTION="User interface toolkit for building highly interactive visualizations of structured and unstructured data."
SRC_URI="mirror://sourceforge/prefuse/${PN}-alpha-${PV/_alpha/}.zip"
HOMEPAGE="http://prefuse.sourceforge.net/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.4"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}-alpha-${PV/_alpha/}

src_unpack() {
	unpack ${A}
	cd ${S}

	cd lib/
	rm -f *.jar
	java-pkg_jar-from ant-core ant.jar
}

src_compile() {
	local antflags="all"
	use doc && antflags="${antflags} api"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc license-prefuse.txt readme.txt
	if use doc; then
		java-pkg_dohtml -r doc/api
	fi
}
