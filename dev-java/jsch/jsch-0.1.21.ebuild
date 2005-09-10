# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsch/jsch-0.1.21.ebuild,v 1.2 2005/09/10 17:40:10 axxo Exp $

inherit java-pkg

DESCRIPTION="JSch is a pure Java implementation of SSH2."
HOMEPAGE="http://www.jcraft.com/jsch/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="jcraft"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc jikes source examples"

RDEPEND=">=virtual/jdk-1.4
	>=dev-java/jzlib-1.0.3
	!sparc? ( dev-java/gnu-crypto )"
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
	if ! use sparc; then
		ant -lib $(java-pkg_getjars gnu-crypto,jzlib) ${antflags} || die "compilation failed"
	else
		ant -lib $(java-pkg_getjars jzlib) ${antflags} || die "compilation failed"
	fi
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
