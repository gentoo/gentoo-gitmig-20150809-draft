# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdictrayapi/jdictrayapi-0.9.1.ebuild,v 1.3 2006/05/02 13:14:39 axxo Exp $

inherit eutils java-pkg

MY_PN="jdic"
MY_P=${MY_PN}-${PV}
DESCRIPTION="The JDesktop Integration Components (JDIC) tray icon API"
HOMEPAGE="https://jdic.dev.java.net/"
SRC_URI="https://jdic.dev.java.net/files/documents/880/16466/${MY_P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples jikes source"

DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		app-arch/unzip
		jikes? ( >=dev-java/jikes-1.21 )
		source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}-src/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/0.8.7-gentoo.patch
	find -type d -name CVS -exec rm -r {} \; >/dev/null 2>&1
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
	use source && java-pkg_dosrc ${S}/src/share/classes/* ${S}/src/unix/classes/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/demo/* ${D}/usr/share/doc/${PF}/examples
	fi
}
