# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-contrib/ant-contrib-1.0_beta1-r2.ebuild,v 1.1 2005/05/18 11:39:29 axxo Exp $

inherit java-pkg

DESCRIPTION="The Ant-Contrib project is a collection of tasks (and at one point maybe types and other tools) for Apache Ant."
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${PN}-${PV/_beta/b}-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
	java-pkg_newjar build/lib/${PN}-${PV}.jar ${PN}.jar

	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/

	dodoc README.txt
	use doc && java-pkg_dohtml -r build/docs
	java-pkg_dohtml -r manual
}
