# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oro/oro-2.0.8.ebuild,v 1.9 2005/01/26 21:43:14 corsair Exp $

inherit java-pkg

DESCRIPTION="A set of text-processing Java classes that provide Perl5 compatible regular expressions, AWK-like regular expressions, glob expressions, and utility classes for performing substitutions, splits, filtering filenames, etc."
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
SRC_URI="mirror://apache/jakarta/oro/source/jakarta-${PN}-${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jdk-1.3"

S=${WORKDIR}/jakarta-oro-${PV}

src_compile() {
	local myc

	if use jikes ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant jar || die "Failed Compiling"

	if use doc ; then
		ant javadocs || die "Failed Creating Docs"
	fi
}

src_install() {
	mv jakarta-oro*.jar oro.jar
	java-pkg_dojar oro.jar
	dodoc CHANGES COMPILE CONTRIBUTORS ISSUES LICENSE README STYLE TODO
	dohtml *.html

	use doc && java-pkg_dohtml -r docs/
}
