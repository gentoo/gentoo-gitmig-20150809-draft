# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/crimson/crimson-1.1.3.ebuild,v 1.10 2005/02/03 20:12:52 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Apache Crimson XML 1.0 parser"
HOMEPAGE="http://xml.apache.org/crimson/"
SRC_URI="http://xml.apache.org/dist/crimson/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 ~ppc amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jars"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_dojar build/crimson.jar
	dodoc build/ChangeLog
	dohtml build/README.html

	if use doc; then
		java-pkg_dohtml -r build/docs
		java-pkg_dohtml -r -A class,java,xml build/examples
	fi
}
