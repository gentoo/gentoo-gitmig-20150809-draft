# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-1.1.5.ebuild,v 1.2 2004/03/22 19:57:19 dholm Exp $

inherit java-pkg

DESCRIPTION="JavaScript Interpreter written in Java"
SRC_URI="http://www.lugrin.ch/fesi/${PN}kit-${PV}.zip"
HOMEPAGE="http://www.lugrin.ch/fesi"
DEPEND=">=virtual/jre-1.4"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~ppc"

S=${WORKDIR}/${PN}

src_compile() { :; }

src_install() {
	java-pkg_dojar fesi.jar
	dodoc Readme.txt
	if [ `use doc` ] ; then
		dohtml -r doc/html/*
		cp -r examples ${D}/usr/share/${PN}
		cp -r tests ${D}/usr/share/${PN}
	fi
}
