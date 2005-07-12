# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/concurrent-util/concurrent-util-1.3.4.ebuild,v 1.9 2005/07/12 13:34:44 axxo Exp $

inherit java-pkg

DESCRIPTION="Doug Lea's concurrency utilities provide standardized, efficient versions of utility classes commonly encountered in concurrent Java programming."
SRC_URI="mirrors://gentoo/gentoo-concurrent-util-1.3.4.tar.bz2"
HOMEPAGE="http://gee.cs.oswego.edu/dl/classes/EDU/oswego/cs/dl/util/concurrent/intro.html"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 sparc ~ppc"
RDEPEND=">=virtual/jre-1.2"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-core-1.5
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
IUSE="doc jikes source"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar build/lib/concurrent.jar
	use source && java-pkg_dosrc src/java/*

	if use doc ; then
		cd build
		java-pkg_dohtml -r javadoc
		insinto /usr/share/doc/${PF}/demo
		doins demo/*
	fi
}
