# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/oro/oro-2.0.6.ebuild,v 1.3 2002/12/15 10:44:11 bjb Exp $

S=${WORKDIR}/jakarta-oro-${PV}
DESCRIPTION="A set of text-processing Java classes that provide Perl5 compatible regular expressions, AWK-like regular expressions, glob expressions, and utility classes for performing substitutions, splits, filtering filenames, etc."
SRC_URI="http://jakarta.apache.org/builds/jakarta-oro/release/v${PV}/jakarta-oro-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
DEPEND=">=virtual/jdk-1.3
		>=ant-1.4"
REDEPND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

src_compile() {
	ant jar || die 
	ant javadocs || die
}

src_install () {
	dojar jakarta-oro*.jar
	dodoc BUGS CHANGES COMPILE CONTRIBUTORS README STYLE TODO
	dohtml *.html
	dodir /usr/share/doc/${P}
	dohtml -r docs/
}

pkg_postinst() {
	einfo "Documentation can be found at http://jakarta.apache.org/oro/index.html"
}
