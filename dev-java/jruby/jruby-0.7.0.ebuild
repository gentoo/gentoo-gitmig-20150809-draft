# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-0.7.0.ebuild,v 1.1 2004/11/16 00:17:20 karltk Exp $

inherit java-pkg

DESCRIPTION="Java based ruby interpreter implementation"
HOMEPAGE="http://jruby.sourceforge.net/"
SRC_URI="mirror://sourceforge/jruby/${PN}-src-${PV}.tar.gz"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc jikes junit"
RDEPEND=">=virtual/jre-1.4
	=dev-java/bsf-2.3*
	=dev-java/oro-2.0*
	=dev-java/gnu-regexp-1.1*"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( dev-java/junit )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -rf *.jar
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from oro
	java-pkg_jar-from gnu-regexp-1
	java-pkg_jar-from ant-core ant.jar
	use junit && java-pkg_jar-from junit
}

src_compile() {
	local antflags="jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	use doc && antflags="${antflags} create-apidocs"

	ant ${antflags} || die "Compile Failed"
}

src_install() {
	java-pkg_dojar ${S}/lib/jruby.jar
	use doc && java-pkg_dohtml -r docs/api/*
}
