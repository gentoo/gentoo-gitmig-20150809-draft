# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/jaimlib/jaimlib-0.5.ebuild,v 1.2 2004/07/17 09:25:19 dholm Exp $

inherit java-pkg

DESCRIPTION="A Java library that implements the AOL Toc protocol"
SRC_URI="mirror://sourceforge/jaimlib/jaimlibsrc-${PV}.tar.gz"
HOMEPAGE="http://jaimlib.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="jikes doc"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5
	jikes? ( >=dev-java/jikes-1.16 )"

RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation problem"
}

src_install() {
	java-pkg_dojar lib/${PN}*.jar
	dodoc readme.txt changes.txt
	use doc && dohtml -r docs/apidoc
}
