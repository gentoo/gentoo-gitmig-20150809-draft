# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/fesi/fesi-1.ebuild,v 1.8 2002/08/01 17:15:54 karltk Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="JavaScript Interpreter written in Java"
SRC_URI="http://home.worldcom.ch/jmlugrin/fesi/${PN}kit.zip"
DEPEND=">=virtual/jre-1.2.2"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86"

src_unpack() {
	jar -xf ${DISTDIR}/fesikit.zip
}

src_install() {                               

	dojar fesi.jar

	into /usr
	dodoc COPYRIGHT.TXT Readme.txt 
	dohtml -r doc/html/*
}
