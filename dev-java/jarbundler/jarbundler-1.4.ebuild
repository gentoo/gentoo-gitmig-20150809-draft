# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jarbundler/jarbundler-1.4.ebuild,v 1.1 2005/12/13 08:36:43 compnerd Exp $

inherit java-pkg

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="http://www.loomcom.com/jarbundler/"
SRC_URI="http://www.loomcom.com/jarbundler/dist/jarbundler-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
		 dev-java/ant-core"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "build failed"
}

src_install() {
	java-pkg_newjar bin/${PF}.jar ${PN}.jar

	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/
}
