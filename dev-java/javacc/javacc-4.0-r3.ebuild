# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-4.0-r3.ebuild,v 1.1 2006/09/10 14:48:34 caster Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java Compiler Compiler - The Java Parser Generator"
HOMEPAGE="https://${PN}.dev.java.net/"
SRC_URI="https://${PN}.dev.java.net/files/documents/17/26783/${P}src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples source"
DEPEND=">=virtual/jdk-1.4
	sys-apps/sed
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

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

	echo "JAVACC_HOME=/usr/share/javacc/" > ${T}/22javacc
	doenvd ${T}/22javacc

	echo "export VERSION=4.0" > ${T}/pre

	local launcher
	for launcher in javacc jjdoc jjtree
	do
		java-pkg_dolauncher ${launcher} -pre ${T}/pre --main ${launcher}
	done
}
