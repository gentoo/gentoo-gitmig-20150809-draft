# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-3.2-r3.ebuild,v 1.4 2004/10/17 07:28:30 absinthe Exp $

inherit java-pkg

DESCRIPTION="Java Compiler Compiler [tm] (JavaCC [tm]) - The Java Parser Generator"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="https://javacc.dev.java.net/files/documents/17/3616/javacc-3.2.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="virtual/jdk
	sys-apps/sed
	dev-java/ant"
RDEPEND="virtual/jre"

src_compile() {
	ant || die "compilation failed"

	cp ${FILESDIR}/${PN}-${PV} ${S}/ || die "Missing env file ${P}"
	sed -i \
		-e "s:@PV@:${PV}:" \
		-e "s:@PN@:${PN}:" \
		${PN}-${PV} || die "Failed to sed"
}

src_install() {
	if use doc ; then
		java-pkg_dohtml -r www/* || die "Failed to install HTML files"
		dodir /usr/share/${PN}/examples
		cp -R examples ${D}/usr/share/${PN} || die "Failed to copy examples"
	fi
	java-pkg_dojar bin/lib/javacc.jar

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
