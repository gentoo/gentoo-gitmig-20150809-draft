# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-net/commons-net-1.2.2.ebuild,v 1.4 2004/07/26 19:10:46 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="The purpose of the library is to provide fundamental protocol access, not higher-level abstractions."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI="mirror://apache/jakarta/commons/net/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.5.4
		>=dev-java/oro-2.0.7"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes doc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-1.2.diff
	#for some reason 1.2.2 claims its 1.3
	sed "s/commons-net-1.3.0-dev/commons-net-1.2.2-dev/" -i build.xml || die "died on sed"
}

src_compile() {
	local antflags="-Doro.jar=$(java-config -p oro) jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "died on ant"
}

src_install() {
	mv ${S}/target/${P}-dev.jar ${S}/target/${PN}.jar
	java-pkg_dojar target/${PN}.jar || die "died on java-pkg_dojar"
	use doc && dohtml -r dist/docs/
}
