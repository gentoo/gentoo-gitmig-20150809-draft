# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/henplus/henplus-0.9.5-r2.ebuild,v 1.5 2005/07/16 15:04:22 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="HenPlus is a SQL shell that can handle multiple sessions in parallel. The commandline interface with the usual history functions features TAB-completion for commands, tables and columns. Database connect via JDBC."
HOMEPAGE="http://henplus.sf.net"
SRC_URI="mirror://sourceforge/henplus/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="jikes"

RDEPEND=">=virtual/jre-1.3
	dev-java/libreadline-java"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	>=dev-java/ant-1.4.1
	jikes? ( >=dev-java/jikes-1.17 )"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/henplus.patch
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	export CLASSPATH="$CLASSPATH:$(java-pkg_getjars libreadline-java)"

	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar build/*.jar
	dodoc README
	dobin bin/henplus
}

