# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/regexp/regexp-1.3-r1.ebuild,v 1.4 2004/10/16 17:33:48 axxo Exp $

inherit java-pkg

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/jakarta-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="0"
IUSE="doc jikes"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc sparc amd64"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core"

S=${WORKDIR}/jakarta-${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir lib
	sed -i 's:./jakarta-site2::' build.xml || die "sed failed"
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile problem"
}

src_install() {
	cd ${S}/build
	mv jakarta-${P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r docs/api/*
}
