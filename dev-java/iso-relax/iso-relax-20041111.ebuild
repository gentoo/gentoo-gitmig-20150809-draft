# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/iso-relax/iso-relax-20041111.ebuild,v 1.6 2006/02/17 05:47:02 nichoj Exp $

inherit java-pkg

DESCRIPTION="Interfaces usefull for applications which support RELAX Core"
SRC_URI="mirror://sourceforge/${PN}/isorelax.${PV}.zip"
HOMEPAGE="http://iso-relax.sourceforge.net/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="source"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.3* )
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )"
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
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar isorelax.jar || die "dojar failed"
	use source && java-pkg_dosrc  src/*
}
