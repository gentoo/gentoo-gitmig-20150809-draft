# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-ecj/eclipse-ecj-3.1-r2.ebuild,v 1.4 2006/09/14 03:25:54 nichoj Exp $

inherit eutils java-pkg

MY_PN=${PN##*-}

DESCRIPTION="Eclipse Compiler for Java"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="mirror://gentoo/${P}-gentoo-r2.tar.bz2"
LICENSE="EPL-1.0"
KEYWORDS="~amd64 ~ppc64 ~x86"
SLOT="3.1"

IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.4"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	dev-java/ant-core"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Failed to compile ecj.jar"
}

src_install() {
	java-pkg_dojar build/${MY_PN}.jar || die "ecj.jar not installable"

	dodoc README
	use doc && java-pkg_dohtml -r build/doc/api

	exeinto /usr/bin
	doexe ${MY_PN}-${SLOT}
}

