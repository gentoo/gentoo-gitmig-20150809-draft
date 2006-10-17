# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jzlib/jzlib-1.0.7-r1.ebuild,v 1.5 2006/10/17 02:40:16 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JZlib is a re-implementation of zlib in pure Java."
HOMEPAGE="http://www.jcraft.com/jzlib/"
SRC_URI="http://www.jcraft.com/${PN}/${P}.tar.gz"

LICENSE="jcraft"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"


src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/jzlib_build.xml ${S}/build.xml || die
	mkdir ${S}/src
	mv ${S}/com/ ${S}/src/
}

src_compile() {
	eant $(use_doc) dist
}

src_install() {
	java-pkg_newjar dist/lib/jzlib*.jar jzlib.jar
	use doc && java-pkg_dohtml -r javadoc/*
	use source && java-pkg_dosrc src
	dodoc README ChangeLog
}
