# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/telnetd/telnetd-1.0-r1.ebuild,v 1.3 2004/10/22 11:49:42 absinthe Exp $

inherit java-pkg

DESCRIPTION="A telnet daemon for use in java applications"
HOMEPAGE="http://telnetd.sourceforge.net/"
SRC_URI="mirror://sourceforge/telnetd/${P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/xerces-2.6.2-r1
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.4"
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2
}

src_compile() {
	antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/telnetd.jar
	use doc && java-pkg_dohtml -r build/site/api/*
}
