# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mckoi/mckoi-1.0.3.ebuild,v 1.3 2005/07/15 19:16:35 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Mckoi Java SQL Database System"
HOMEPAGE="http://mckoi.com/database/"
SRC_URI="http://www.mckoi.com/database/ver/${P/-/}.zip"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.4
	=dev-java/gnu-regexp-1.1*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.6.2
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )"

S=${WORKDIR}/${P/-/}

src_unpack() {
	unpack ${A}
	cd ${S}

	unzip -q src.zip || die "unpack failed"
	epatch ${FILESDIR}/mckoi-1.0.3-jikes.patch

	rm gnu-regexp-*
	rm *.jar

	cp ${FILESDIR}/build.xml .
	echo "gnu-regexp.jar=$(java-pkg_getjars gnu-regexp-1)" > build.properties

	cd src/
	rm -rf net
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compiling failed"
}

src_install() {
	dodoc README.txt db.conf
	java-pkg_dojar dist/mckoidb.jar

	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
