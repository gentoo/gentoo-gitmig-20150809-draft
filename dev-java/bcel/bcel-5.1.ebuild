# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1.ebuild,v 1.31 2005/01/26 21:37:43 corsair Exp $

inherit java-pkg eutils

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="mirror://apache/jakarta/bcel/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.2
	app-arch/unzip
	>=dev-java/regexp-1.3-r1
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.2
	>=dev-java/regexp-1.3-r1"

src_unpack() {
	unpack ${A}
	unzip -q "${P}-src.zip"

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-buildxml.diff
	epatch ${FILESDIR}/${P}-gentoo-src.diff

	echo "regexp.jar=`java-config -p regexp`" > build.properties
}

src_compile() {
	local antflags="jar"

	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	if use doc; then
		antflags="${antflags} apidocs"
	fi
	ant ${antflags}
}

src_install() {
	if use doc; then
		java-pkg_dohtml -r docs/
	fi

	dodoc LICENSE.txt
	java-pkg_dojar bin/bcel.jar
}
