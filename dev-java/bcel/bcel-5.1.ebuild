# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1.ebuild,v 1.14 2004/07/30 21:35:04 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="http://archive.apache.org/dist/jakarta/bcel/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
RESTRICT="nomirror"
KEYWORDS="x86 ~ppc sparc amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/regexp-bin-1.2
	jikes? ( dev-java/jikes )"
RDEPEND="${DEPEND}"
DEP_APPEND="regexp"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	unzip -q "${P}-src.zip"
}

src_compile() {
	ANT_OPTS="${myc}"
	CLASSPATH="${CLASSPATH}:`/usr/bin/java-config --classpath=regexp`"
	epatch ${FILESDIR}/${P}-gentoo.diff

	use jikes && export ANT_OPTS="${ANT_OPTS} -Dbuild.compiler=jikes"
	ant jar || die "Compile failed during jar target."
	if use doc ; then
		echo "Building Javadocs"
		ant apidocs > /dev/null
	fi
}

src_install() {
	use doc && dohtml -r docs/
	dodoc LICENSE.txt
	java-pkg_dojar bin/bcel.jar
}
