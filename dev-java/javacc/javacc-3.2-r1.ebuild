# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-3.2-r1.ebuild,v 1.4 2004/04/26 03:37:17 zx Exp $

inherit java-pkg

DESCRIPTION="Java Compiler Compiler [tm] (JavaCC [tm]) - The Java Parser Generator"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="https://javacc.dev.java.net/files/documents/17/3616/javacc-3.2.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND="virtual/jdk
		dev-java/ant"
RDEPEND="virtual/jre"

src_compile() {
	ant || die "compilation failed"
}

src_install() {
	use doc && dohtml -r www/* && dodir /usr/share/${PN}/examples && cp -R ${S}/examples ${D}/usr/share/${PN}
	java-pkg_dojar bin/lib/javacc.jar
	dobin ${FILESDIR}/javacc
	dobin ${FILESDIR}/jjdoc
	dobin ${FILESDIR}/jjtree
	insinto /etc/env.d
	newins ${FILESDIR}/${P} 22${PN}
}
