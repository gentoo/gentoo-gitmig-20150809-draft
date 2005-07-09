# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/glazedlists/glazedlists-0.9.6.ebuild,v 1.3 2005/07/09 13:48:40 swegener Exp $

inherit java-pkg

DESCRIPTION="A toolkit for list transformations"
HOMEPAGE="http://publicobject.com/glazedlists/"
SRC_URI="https://glazedlists.dev.java.net/files/documents/1073/13000/${P}-source.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes junit source"
RESTRICT="nomirror"
DEPEND="virtual/jdk
	dev-java/ant
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	junit? ( dev-java/junit )"
S=${WORKDIR}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	use doc && antflags="${antflags} docs"
	ant ${antflags} || die "compile problem"
}
src_install() {
	java-pkg_dojar glazedlists.jar
	use doc && java-pkg_dohtml docs && dohtml readme.html
	use source && java-pkg_dosrc source
}
