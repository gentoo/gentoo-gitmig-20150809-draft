# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/randomguid/randomguid-1.2.ebuild,v 1.1 2002/07/08 18:05:05 blizzy Exp $

A="RandomGUID.tar"
S=${WORKDIR}
SRC_URI="ftp://www.javaexchange.com/javaexchange/${A}"
DESCRIPTION="Generate truly random, cryptographically strong GUIDs"
HOMEPAGE="http://www.javaexchange.com"
LICENSE="as-is"
SLOT="0"
KEYWORDS="*"

RDEPEND=">=virtual/jdk-1.2"
DEPEND="${RDEPEND}
	jikes? ( >=dev-java/jikes-1.15 )"

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

	if [ `use jikes` ] ; then
		jikes RandomGUID.java || die "compile problem"
	else
		javac RandomGUID.java || die "compile problem"
	fi

	# don't want .java files in jar
	rm RandomGUID.java*

	cd ${S}
	jar cf RandomGUID.jar com || die "jar problem"
}

src_install() {
	dojar RandomGUID.jar
	dodoc RandomGUIDdemo.java
}

pkg_postinst() {
	einfo "RandomGUID.class has been moved from the <default>"
	einfo "package into com.javaexchange, so the fully qualified"
	einfo "class name is now: com.javaexchange.RandomGUID"
}
