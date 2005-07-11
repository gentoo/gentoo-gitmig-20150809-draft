# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sablecc-anttask/sablecc-anttask-1.1.0.ebuild,v 1.6 2005/07/11 09:20:22 axxo Exp $

inherit java-pkg

DESCRIPTION="Ant task for sablecc"
HOMEPAGE="http://sablecc.org/"
SRC_URI="mirror://sourceforge/sablecc/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	dev-java/sablecc"

RESTRICT="primaryuri"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodir /usr/share/ant-core/lib/
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
	java-pkg_dohtml -r doc
	dodoc AUTHORS ChangeLog README
}
