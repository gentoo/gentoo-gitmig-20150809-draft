# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1.ebuild,v 1.23 2004/10/29 17:21:46 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="http://archive.apache.org/dist/jakarta/bcel/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/regexp-1.3-r1
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
DEP_APPEND="regexp"
RESTRICT="nomirror"

src_unpack() {
	unpack ${A}
	unzip -q "${P}-src.zip"
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	ANT_OPTS="${myc}"
	CLASSPATH="${CLASSPATH}:`/usr/bin/java-config --classpath=regexp`"

	use jikes && export ANT_OPTS="${ANT_OPTS} -Dbuild.compiler=jikes"
	ant jar || die "Compile failed during jar target."
	if use doc ; then
		echo "Building Javadocs"
		ant apidocs > /dev/null
	fi
}

src_install() {
	use doc && java-pkg_dohtml -r docs/
	dodoc LICENSE.txt
	java-pkg_dojar bin/bcel.jar
}
