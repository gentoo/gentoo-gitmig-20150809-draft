# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1.ebuild,v 1.1 2003/05/15 06:58:30 absinthe Exp $

inherit java-pkg

S=${WORKDIR}/${P}
DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files."
SRC_URI="http://jakarta.apache.org/builds/jakarta-bcel/release/v${PV}/${PN}-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org/bcel/"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2
	>=dev-java/regexp-1.2
	jikes? ( dev-java/jikes )"
IUSE="doc jikes"
DEP_APPEND="regexp"

src_compile() {
	ANT_OPTS="${myc}"
	CLASSPATH="${CLASSPATH}:`/usr/bin/java-config --classpath=regexp`"
	epatch ${FILESDIR}/${P}-gentoo.diff
	
	use jikes && export ANT_OPTS="${ANT_OPTS} -Dbuild.compiler=jikes"
	ant jar || die "Compile failed during jar target."
	if [ -n "`use doc`" ] ; then
		echo "Building Javadocs"
		ant apidocs > /dev/null
	fi
}

src_install() {
	use doc && dohtml -r docs/
	dodoc LICENSE.txt 
	java-pkg_dojar bin/bcel.jar
}

