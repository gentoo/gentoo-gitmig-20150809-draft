# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swarmcache/swarmcache-1.0_pre20050106.ebuild,v 1.1 2005/01/06 23:17:04 luckyduck Exp $

inherit java-pkg

DESCRIPTION="SwarmCache is a simple but effective distributed cache."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://swarmcache.sourceforge.net"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=virtual/jre-1.3
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.5"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-collections-3
	>=dev-java/commons-logging-1.0.4
	>=dev-java/jgroups-2.2.7"
IUSE="doc jikes"

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	java-pkg_jar-from commons-collections
	java-pkg_jar-from commons-logging
	java-pkg_jar-from jgroups
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc *.txt
	use doc && java-pkg_dohtml -r web/api/*
}
