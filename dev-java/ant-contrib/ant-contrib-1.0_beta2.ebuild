# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-contrib/ant-contrib-1.0_beta2.ebuild,v 1.2 2005/07/16 15:02:23 axxo Exp $

inherit java-pkg

DESCRIPTION="The Ant-Contrib project is a collection of tasks (and at one point maybe types and other tools) for Apache Ant."
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${PN}-${PV/_beta/b}-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-1.6.2
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/bcel-5.1
	dev-java/xerces"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	java-pkg_jarfrom bcel bcel.jar bcel-5.1.jar
}

src_compile() {
	local antflags="jar -Dversion=${PV}"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/

	dodoc README.txt
	use doc && java-pkg_dohtml -r build/docs
	java-pkg_dohtml -r manual
}
