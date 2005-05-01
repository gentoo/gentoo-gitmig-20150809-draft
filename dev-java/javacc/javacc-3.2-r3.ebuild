# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-3.2-r3.ebuild,v 1.6 2005/05/01 09:55:56 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Java Compiler Compiler [tm] (JavaCC [tm]) - The Java Parser Generator"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="https://javacc.dev.java.net/files/documents/17/3616/javacc-3.2.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc examples jikes source"
DEPEND=">=virtual/jdk-1.3
	sys-apps/sed
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"

	cp ${FILESDIR}/${PN}-${PV} ${S}/ || die "Missing env file ${P}"
	sed -i \
		-e "s:@PV@:${PV}:" \
		-e "s:@PN@:${PN}:" \
		${PN}-${PV} || die "Failed to sed"
}

src_install() {
	java-pkg_dojar bin/lib/${PN}.jar

	if use doc; then
		dodoc README
		java-pkg_dohtml -r www/*
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R examples/* ${D}/usr/share/doc/${PF}/examples 
	fi
	use source && java-pkg_dosrc src/*

	newbin ${FILESDIR}/javacc.sh-${PV} javacc
	newbin ${FILESDIR}/jjdoc-${PV} jjdoc
	newbin ${FILESDIR}/jjtree-${PV} jjtree

	dodir /etc/env.d/java
	insinto /etc/env.d/java
	newins ${PN}-${PV} 22javacc || die "Missing ${PF}"
}

pkg_postinst() {
	#close bug 61975
	if [ -f /etc/env.d/22javacc ] ; then
		rm -f /etc/env.d/22javacc
	fi
}
