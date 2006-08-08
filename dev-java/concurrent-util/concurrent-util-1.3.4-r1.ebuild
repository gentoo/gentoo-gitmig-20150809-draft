# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/concurrent-util/concurrent-util-1.3.4-r1.ebuild,v 1.2 2006/08/08 19:15:35 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Doug Lea's concurrency utilities provide standardized, efficient versions of utility classes commonly encountered in concurrent Java programming."
SRC_URI="mirror://gentoo/gentoo-concurrent-util-1.3.4.tar.bz2"
HOMEPAGE="http://gee.cs.oswego.edu/dl/classes/EDU/oswego/cs/dl/util/concurrent/intro.html"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
RDEPEND=">=virtual/jre-1.2"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-core-1.5
	source? ( app-arch/zip )"
IUSE="doc source"

src_compile() {
	eant $(use_doc doc) jar
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
