# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-1.1.ebuild,v 1.1 2004/02/16 17:52:56 zx Exp $

inherit java-pkg

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/jabref/JabRef-${PV}-src.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="jikes"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.4.1
		jikes? ( dev-java/jikes )"

src_compile() {
	local antflags="jars"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/lib/*.jar
}
