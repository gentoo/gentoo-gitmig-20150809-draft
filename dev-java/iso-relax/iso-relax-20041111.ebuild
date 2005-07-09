# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/iso-relax/iso-relax-20041111.ebuild,v 1.5 2005/07/09 16:02:44 axxo Exp $

inherit java-pkg

DESCRIPTION="Interfaces usefull for applications which support RELAX Core"
SRC_URI="mirror://sourceforge/${PN}/isorelax.${PV}.zip"
HOMEPAGE="http://iso-relax.sourceforge.net/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="jikes source"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.3* )
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.3* )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -f isorelax.jar
	mkdir src/
	unzip -d src/ src.zip
	rm -r src/src
	rm -rf src/jp/gr/xml/relax/swift # this is obsolete and not needed
	cp ${FILESDIR}/build.xml .
}

src_compile() {
	local antflags="release"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar isorelax.jar || die "dojar failed"
	use source && java-pkg_dosrc  src/*
}
