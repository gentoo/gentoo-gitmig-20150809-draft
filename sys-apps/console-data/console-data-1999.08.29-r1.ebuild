# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-data/console-data-1999.08.29-r1.ebuild,v 1.3 2000/09/15 20:09:16 drobbins Exp $

P=console-data-1999.08.29      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Data (fonts, keymaps) for the consoletools package"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/"${A}
HOMEPAGE="http://altern.org/ydirson/en/lct/data.html"

src_compile() {                           

	try ./configure --host=${CHOST} --prefix=/usr
	try make 

}

src_install() {   
 
    dodoc ChangeLog doc/README.*
    try make DESTDIR=${D} install

}


