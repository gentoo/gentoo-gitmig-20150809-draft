# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-collections/commons-collections-3.0-r1.ebuild,v 1.2 2004/06/24 22:20:36 agriffis Exp $

inherit java-pkg

DESCRIPTION="Jakarta-Commons Collections Component"
HOMEPAGE="http://jakarta.apache.org/commons/collections.html"
SRC_URI="mirror://apache/jakarta/commons/collections/source/${PN}-${PV}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc jikes junit"

src_compile() {
	echo "junit.jar=`java-config -p junit`" >> build.properties
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags}
}

src_install() {
	mv build/${P}.jar build/${PN}.jar
	java-pkg_dojar build/${PN}.jar
	dodoc LICENSE.txt README.txt
	use doc && dohtml -r build/docs/apidocs
	dohtml *.html
}

