# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/root-docs/root-docs-3.03.04.ebuild,v 1.2 2002/07/11 06:30:11 drobbins Exp $

S=${WORKDIR}/htmldoc

DESCRIPTION="An Object-Oriented Data Analysis Framework"
SRC_URI="ftp://root.cern.ch/root/html303.tar.gz"
HOMEPAGE="http://root.cern.ch/"

src_compile() {

	einfo "Nothing to compile."

}

src_install() {

    cd ${S}
    
    dohtml *
	docinto postscript
	dodoc *.ps

}


