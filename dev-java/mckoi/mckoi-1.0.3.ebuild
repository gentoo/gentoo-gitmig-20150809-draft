# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mckoi/mckoi-1.0.3.ebuild,v 1.1 2004/12/21 11:51:11 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="Mckoi Java SQL Database System"
HOMEPAGE="http://mckoi.com/database/"
SRC_URI="http://www.mckoi.com/database/ver/${P/-/}.zip"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.2
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/gnu-regexp-1.1*"

S=${WORKDIR}/${P/-/}

src_unpack() {
	unpack ${A}
	cd ${S}

	unzip -q src.zip || die "unpack failed"
	epatch ${FILESDIR}/mckoi-1.0.3-jikes.patch

	rm gnu-regexp-*
	rm *.jar

	cp ${FILESDIR}/build.xml .
	echo "gnu-regexp.jar=`java-config -p gnu-regexp-1`" > build.properties

	cd src/
	rm -rf net
}

src_compile() {
	local antflags="jar"
	if use doc; then
		antflags="${antflags} docs"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "compiling failed"
}

src_install() {
	dodoc LICENSE.txt README.txt db.conf
	java-pkg_dojar dist/mckoidb.jar

	if use doc; then
		java-pkg_dohtml -r docs/*
	fi
}
