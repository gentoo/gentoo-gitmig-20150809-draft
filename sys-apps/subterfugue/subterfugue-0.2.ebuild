# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/subterfugue/subterfugue-0.2.ebuild,v 1.1 2001/09/25 16:00:47 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="strace meets expect"

SRC_URI="http://prdownloads.sourceforge.net/subterfugue/subterfugue-0.2.tgz"

HOMEPAGE="http://www.subterfugue.org"

DEPEND=">=dev-lang/python-2.0
        gtk? ( >=x11-libs/gtk+-1.2.8 )"

src_unpack() {

    unpack ${P}.tgz
    
    cd ${S}
    
    cp Makefile Makefile.orig
    sed "s/python1.5/python2.0/" < Makefile.orig > Makefile
}

src_compile() {

    # breaks down with emake
    make || die
    
    cp dsf dsf.orig
    sed -e "s:SUBTERFUGUE_ROOT=.*:SUBTERFUGUE_ROOT=/usr/share/subterfuge/:" \
    < dsf.orig > sf
    
}

src_install () {
	
    into /usr

    dobin sf
    
    dodoc COPYING CREDITS GNU-entry INSTALL INTERNALS NEWS README TODO
    
    doman doc/sf.1

    SH=/usr/share/subterfuge
        
    exeinto ${SH}
    doexe *.{py,pyc}

    exeinto ${SH}/tricks
    doexe tricks/*.{py,pyc}
    
    exeinto ${SH}/modules
    doexe modules/*.so
    
}

