# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/henplus/henplus-0.9.5.ebuild,v 1.1 2004/02/16 18:43:55 zx Exp $

inherit java-pkg

DESCRIPTION="HenPlus is a SQL shell that can handle multiple sessions in parallel. The commandline interface with the usual history functions features TAB-completion for commands, tables and columns. Database connect via JDBC."
HOMEPAGE="http://www.sourceforge.net/projects/henplus"
SRC_URI="mirror://sourceforge/henplus/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4.1
	dev-java/libreadline-java
	jikes? ( >=dev-java/jikes-1.17 )"

RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	export CLASSPATH="$CLASSPATH:`java-config --classpath=libreadline-java`"

	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar build/*.jar
	dodoc README
}

