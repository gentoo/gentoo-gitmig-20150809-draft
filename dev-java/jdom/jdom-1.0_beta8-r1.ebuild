# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta8-r1.ebuild,v 1.2 2002/08/01 18:04:16 karltk Exp $

P="jdom-b8"
A="jdom-b8.tar.gz"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/${A}"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="x86"
RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4.1
	jikes? ( >=dev-java/jikes-1.15 )"

src_compile() {
	local antflags

	antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "compile problem"
}

src_install() {
	dojar build/jdom*.jar lib/*.jar

	dodoc CHANGES.txt COMMITTERS.txt LICENSE.txt README.txt TODO.txt
	dohtml -r build/apidocs/*
}
