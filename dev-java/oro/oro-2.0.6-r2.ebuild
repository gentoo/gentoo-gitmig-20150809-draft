# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/oro/oro-2.0.6-r2.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

S=${WORKDIR}/jakarta-oro-${PV}
DESCRIPTION="A set of text-processing Java classes that provide Perl5 compatible regular expressions, AWK-like regular expressions, glob expressions, and utility classes for performing substitutions, splits, filtering filenames, etc."
SRC_URI="mirror://apache/jakarta/oro/source/jakarta-oro-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		jikes? ( >=dev-java/jikes-1.17 )"
REDEPND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="doc jikes"

src_compile() {
	local myc

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant jar || die "Failed Compiling"

	if [ -n "`use doc`" ] ; then
		ant javadocs || die "Failed Creating Docs"
	fi
}

src_install () {
	mv jakarta-oro*.jar oro.jar
	dojar oro.jar || die "Failed Installing"
	dodoc BUGS CHANGES COMPILE CONTRIBUTORS README STYLE TODO
	dohtml *.html

	if [ -n "`use doc`" ] ; then
		dodir /usr/share/doc/${P}
		dohtml -r docs/
	fi
}
