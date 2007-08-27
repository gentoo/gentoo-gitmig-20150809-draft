# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/randomguid/randomguid-1.2.1-r1.ebuild,v 1.4 2007/08/27 15:44:12 angelos Exp $

inherit java-pkg-2

DESCRIPTION="Generate truly random, cryptographically strong GUIDs"
HOMEPAGE="http://www.javaexchange.com"
SRC_URI="ftp://www.javaexchange.com/javaexchange/RandomGUID.tar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}

src_compile() {
	mkdir -p com/javaexchange
	mv RandomGUID.java com/javaexchange/RandomGUID.java~

	# We need to move RandomGUID.class into the
	# com.javaexchange package. This is necessary to prevent
	# class lookup failures, such as when used with Tomcat
	# (which has a different <default> package for JSP files).
	cd com/javaexchange
	echo >RandomGUID.java "package com.javaexchange;"
	cat RandomGUID.java~ >>RandomGUID.java

	ejavac RandomGUID.java || die "compile problem"

	# don't want .java files in jar
	rm RandomGUID.java*

	cd ${S}
	jar cf RandomGUID.jar com || die "jar problem"
}

src_install() {
	java-pkg_dojar RandomGUID.jar
	java-pkg_dolauncher ${PN} \
		--main com.javaexchange.RandomGUID
	dodoc RandomGUIDdemo.java
}

pkg_postinst() {
	elog "RandomGUID.class has been moved from the <default>"
	elog "package into com.javaexchange, so the fully qualified"
	elog "class name is now: com.javaexchange.RandomGUID"
}
