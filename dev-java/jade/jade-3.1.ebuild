# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jade/jade-3.1.ebuild,v 1.2 2004/03/23 03:07:57 zx Exp $

inherit java-pkg

DESCRIPTION="JADE is  FIPA-compliant Java Agent Development Environment"
SRC_URI="http://www.cs.bath.ac.uk/~occ/jade-dl/JADE-src-${PV}.zip"
HOMEPAGE="http://jade.cselt.it/"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"

S=${WORKDIR}/${PN}

src_unpack() {
	jar xvf ${DISTDIR}/JADE-src-${PV}.zip
}

src_compile(){
	local antflags="lib"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags} || die "compilation problem"
}

src_install() {
	java-pkg_dojar lib/*.jar
	dodoc README ChangeLog
	use doc && dohtml -r doc/*
}
