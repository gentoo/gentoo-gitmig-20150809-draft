# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jconfig/jconfig-2.8-r1.ebuild,v 1.1 2004/10/30 21:21:26 axxo Exp $

inherit java-pkg

DESCRIPTION="jConfig is an extremely helpful utility, providing a simple API for the management of properties."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-v${PV}.tar.gz"
HOMEPAGE="http://www.jconfig.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/jmx
		>=dev-java/ant-1.4.1
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN/c/C}"

src_unpack() {
	unpack ${A}
	cd ${S}/lib/
	rm -f *.jar
	java-pkg_jar-from jmx
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/jconfig.jar
	use doc && java-pkg_dohtml -r javadoc/*

	dodoc README
}
