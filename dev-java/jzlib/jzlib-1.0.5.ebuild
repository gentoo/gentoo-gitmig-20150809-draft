# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jzlib/jzlib-1.0.5.ebuild,v 1.4 2004/10/16 17:28:21 axxo Exp $

inherit java-pkg

DESCRIPTION="JZlib is a re-implementation of zlib in pure Java."
HOMEPAGE="http://www.jcraft.com/jzlib/"
SRC_URI="http://www.jcraft.com/${PN}/${PN}-${PV}.tar.gz"

LICENSE="jcraft"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE="doc jikes"
RESTRICT="nomirror"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jdk-1.4"


src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/jzlib_build.xml ${S}/build.xml
	mkdir ${S}/src
	mv ${S}/com/ ${S}/src/
}

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	mv dist/lib/jzlib{*,}.jar
	java-pkg_dojar dist/lib/jzlib.jar || die "installation failed"
	use doc && java-pkg_dohtml -r javadoc/*
	dodoc LICENSE.txt README ChangeLog
}
