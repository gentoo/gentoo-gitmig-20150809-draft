# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsch/jsch-0.1.18.ebuild,v 1.13 2006/10/05 17:51:48 gustavoz Exp $

inherit java-pkg

DESCRIPTION="JSch is a pure Java implementation of SSH2."
HOMEPAGE="http://www.jcraft.com/jsch/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="jcraft"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64"
IUSE="doc jikes source examples"

RDEPEND=">=virtual/jdk-1.4
	>=dev-java/jzlib-1.0.3
	dev-java/gnu-crypto"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6
	app-arch/unzip
	source? ( app-arch/zip )
	jikes? ( >=dev-java/jikes-1.17 )
	${RDEPEND}"

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -lib $(java-pkg_getjars gnu-crypto,jzlib) ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_newjar dist/lib/jsch*.jar jsch.jar
	use doc && java-pkg_dohtml -r javadoc/*
	use source && java-pkg_dosrc src/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples/
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples/ || die
	fi
	dodoc README ChangeLog
}
