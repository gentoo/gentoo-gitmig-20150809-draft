# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/noweb/noweb-2.9.ebuild,v 1.2 2001/08/01 18:51:03 danarmak Exp $

S=${WORKDIR}/src
SRC_URI="ftp://ftp.dante.de/tex-archive/web/noweb/src.tar.gz"

HOMEPAGE="http://www.eecs.harvard.edu/~nr/noweb/"
DESCRIPTION="a literate programming tool, lighter than web"

DEPEND="dev-lang/icon
	sys-devel/gcc
	app-text/tetex
	sys-apps/gawk"

src_unpack() {
    
    unpack ${A}
    cd ${S}
    patch -p0 <${FILESDIR}/${P}-gentoo.diff
    
}

src_compile() {
    
    try make

}

src_install () {

    try make DESTDIR=${D} install
    
    [ -x /usr/bin/nawk ] || dosym /usr/bin/gawk /usr/bin/nawk

}

