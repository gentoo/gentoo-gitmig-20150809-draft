# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1-r1.ebuild,v 1.1 2005/03/27 17:45:54 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="mirror://apache/jakarta/bcel/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc64"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.2
	app-arch/unzip
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.2
	=dev-java/jakarta-regexp-1.3*"

src_unpack() {
	unpack ${A}
	unzip -q "${P}-src.zip"

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-buildxml.diff
	epatch ${FILESDIR}/${P}-gentoo-src.diff

	echo "regexp.jar=`java-config -p jakarta-regexp-1.3`" > build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} apidocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar bin/bcel.jar

	if use doc; then
		dodoc LICENSE.txt
		java-pkg_dohtml -r docs/
	fi
	use source && java-pkg_dosrc src/java/*
}
