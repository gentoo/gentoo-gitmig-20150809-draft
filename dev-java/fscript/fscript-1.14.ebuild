# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fscript/fscript-1.14.ebuild,v 1.1 2004/02/19 03:42:13 zx Exp $

inherit java-pkg

DESCRIPTION="Java based scripting engine designed to be embedded into other Java applications."
HOMEPAGE="http://fscript.sourceforge.net/"
SRC_URI="mirror://sourceforge/fscript/${P}.tgz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc jikes"

S="${WORKDIR}/${P}"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} jdoc"

	ant ${antflags}
}

src_install () {
	java-pkg_dojar *.jar
	dodoc CREDITS README VERSION
	use doc && dohtml -r docs/ && cp -r examples/ ${D}/usr/share/${PN}/
}
