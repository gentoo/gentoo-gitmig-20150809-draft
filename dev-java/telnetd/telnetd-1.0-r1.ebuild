# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/telnetd/telnetd-1.0-r1.ebuild,v 1.7 2005/07/15 14:31:43 axxo Exp $

inherit java-pkg

DESCRIPTION="A telnet daemon for use in java applications"
HOMEPAGE="http://telnetd.sourceforge.net/"
SRC_URI="mirror://sourceforge/telnetd/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.4
		>=dev-java/xerces-2.6.2-r1"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		app-arch/unzip
		jikes? ( dev-java/jikes )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/telnetd.jar
	use doc && java-pkg_dohtml -r build/site/api/*
}
