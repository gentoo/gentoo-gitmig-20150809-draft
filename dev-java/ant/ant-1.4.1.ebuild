# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.4.1.ebuild,v 1.1 2001/12/12 02:34:17 karltk Exp $

A="jakarta-ant-${PV}-src.tar.gz"
S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ant/release/v${PV}/src/jakarta-ant-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

DEPEND="virtual/glibc
        >=virtual/jdk-1.3"

src_compile() {
	./bootstrap.sh
}

src_install() {
	exeinto /usr/bin
	doexe src/script/ant

	insinto /usr/share/ant
	doins build/lib/*.jar lib/*.jar
	insinto /usr/share/ant

	ls ${D}/usr/share/ant/*.jar | \
		tr '\n' ':' \
		> ${D}/usr/share/ant/classpath.env
	dosed usr/share/ant/classpath.env
	
	dodoc LICENSE README WHATSNEW KEYS
	dohtml -r docs/*
}



