# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdictrayapi/jdictrayapi-0.8.7.ebuild,v 1.4 2005/05/04 19:19:52 luckyduck Exp $

inherit eutils java-pkg

MY_P="jdic"
DESCRIPTION="The JDesktop Integration Components (JDIC) tray icon API"
HOMEPAGE="https://jdic.dev.java.net/"
SRC_URI="https://jdic.dev.java.net/files/documents/880/9849/jdic-${PV}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc examples jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}-${PV}-src/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_compile() {
	local antflags="buildtray"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	cd ${WORKDIR}/${MY_P}-${PV}-src/

	cd ${S}/dist/linux
	java-pkg_dojar jdic.jar
	java-pkg_doso libtray.so

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc ${S}/src/unix/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/demo/* ${D}/usr/share/doc/${PF}/examples
	fi
}
