# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-4.0-r1.ebuild,v 1.1 2006/07/03 14:29:20 nichoj Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java Compiler Compiler"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="https://${PN}.dev.java.net/files/documents/17/26783/${P}src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples source"
DEPEND=">=virtual/jdk-1.3
	sys-apps/sed
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-javadoc.patch
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar bin/lib/${PN}.jar

	if use doc; then
		dodoc README
		java-pkg_dohtml -r www/*
		java-pkg_dohtml -r doc/api
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/*

	newenvd ${FILESDIR}/javacc-${PV} 22javacc

	java-pkg_dolauncher javacc --main javacc
	java-pkg_dolauncher jjdoc --main jjdoc
	java-pkg_dolauncher jjree --main jjtree
}
