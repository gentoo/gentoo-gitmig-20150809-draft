# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-contrib/ant-contrib-1.0_beta1.ebuild,v 1.2 2004/07/31 22:35:43 axxo Exp $

inherit java-pkg

DESCRIPTION="The Ant-Contrib project is a collection of tasks (and at one point maybe types and other tools) for Apache Ant."
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${PN}-${PV/_beta/b}-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes doc"
DEPEND=">=dev-java/ant-1.6.2
		>=virtual/jdk-1.4
		dev-java/xerces
		jikes? ( dev-java/jikes )"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="jar -Dversion=${PV} -lib $(java-config -p xerces-2)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar build/lib/${PN}-${PV}.jar || die "pkg jar not found"

	dodir /usr/share/ant/lib
	dosym /usr/share/${PN}/lib/${PN}-${PV}.jar /usr/share/ant/lib/

	dodoc README.txt
	use doc && dohtml -r build/docs
	dohtml -r manual
}
