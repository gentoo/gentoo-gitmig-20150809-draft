# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-oro/jakarta-oro-2.0.8.ebuild,v 1.2 2005/04/02 18:07:37 luckyduck Exp $

inherit java-pkg

DESCRIPTION="A set of text-processing Java classes that provide Perl5 compatible regular expressions, AWK-like regular expressions, glob expressions, and utility classes for performing substitutions, splits, filtering filenames, etc."
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
SRC_URI="mirror://apache/jakarta/oro/source/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE="doc examples jikes source"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.17 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Failed Creating Docs"
}

src_install() {
	mv ${PN}*.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	if use doc; then
		dodoc CHANGES COMPILE CONTRIBUTORS ISSUES LICENSE README STYLE TODO
		java-pkg_dohtml *.html
		java-pkg_dohtml -r docs/
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/org
}
