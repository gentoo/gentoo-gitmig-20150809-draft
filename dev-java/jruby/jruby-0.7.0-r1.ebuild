# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-0.7.0-r1.ebuild,v 1.2 2005/04/02 21:43:38 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Java based ruby interpreter implementation"
HOMEPAGE="http://jruby.sourceforge.net/"
SRC_URI="mirror://sourceforge/jruby/${PN}-src-${PV}.tar.gz"
KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc examples jikes junit source"
RDEPEND=">=virtual/jre-1.4
	=dev-java/bsf-2.3*
	=dev-java/jakarta-oro-2.0*
	=dev-java/gnu-regexp-1.1*"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( dev-java/junit )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -rf *.jar
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from gnu-regexp-1
	use junit && java-pkg_jar-from junit
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} create-apidocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "Compile Failed"
}

src_install() {
	java-pkg_dojar ${S}/lib/jruby.jar

	use doc && java-pkg_dohtml -r docs/api/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r samples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/org
}
