# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gantoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-3.9.37.ebuild,v 1.1 2001/07/21 14:42:00 danarmak Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Allegro is a cross-platform multimedia library"

SRC_URI="http://prdownloads.sourceforge.net/alleg/${P}.tar.gz"

HOMEPAGE="http://alleg.sourceforge.net/allegro/"

DEPEND="X? ( virtual/x11 )"

src_compile() {
    
    confopts="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}"
    
    # Static and shared libs can be build at the same time
    confopts="${confopts} --enable-shared --enable-static"
    
    # Always enable Linux console support and accompanying drivers
    confopts="${confopts} --enable-linux --enable-vga"
    
    # if USE static defined, use static library as default to link with
    if [ "`use static`" ]
    then 
        confopts="${confopts} --enable-staticprog"
    fi
    
    # Pentium optimizations
    if [ ${CHOST} = "i586-pc-linux-gnu" -o ${CHOST} = "i686-pc-linux-gnu" ]
    then 
        confopts="${confopts} --enable-pentiumopts"
    fi
    
    # Use MMX instructions
    if [ "`use mmx`" ]
    then 
        confopts="${confopts} --enable-mmx"
    else
        confopts="${confopts} --enable-mmx=no"
    fi
    
    # Have OSS support
    if [ "`use oss`" ] ; then 
        confopts="${confopts} --enable-ossdigi --enable-ossmidi"
    else
        confopts="${confopts} --disable-ossdigi --disable-ossmidi"
    fi
    
    # Have ALSA support
    if [ "`use alsa`" ] ; then 
        confopts="${confopts} --enable-alsadigi --enable-alsamidi"
    else
        confopts="${confopts} --disable-alsadigi --disable-alsamidi"
    fi
    
    # Have ESD support
    if [ "`use esd`" ] ; then 
        confopts="${confopts} --enable-esddigi"
    else
        confopts="${confopts} --disable-esddigi"
    fi
    
    # Have X11 support
    if [ "`use X`" ] ; then 
        confopts="${confopts} --with-x --enable-xwin-shm --enable-xwin-vidmode --enable-xwin-dga --enable-xwin-dga2"
    else
        confopts="${confopts} --without-x --disable-xwin-shm --disable-xwin-vidmode --disable-xwin-dga --disable-xwin-dga2"
    fi
    
    # Have SVGALib support
    if [ "`use svga`" ] ; then 
        confopts="${confopts} --enable-svgalib"
    else
        confopts="${confopts} --disable-svgalib"
    fi
    
    # Have fbcon support
    if [ "`use fbcon`" ] ; then 
        confopts="${confopts} --enable-fbcon"
    else
        confopts="${confopts} --disable-fbcon"
    fi

    # --------------

    try ./configure ${confopts}
    
    # emake doesn't work
    try make
    
    try make docs-ps docs-dvi
    
}

src_install () {
	
    try make prefix=${D}/usr infodir=${D}/usr/share/info mandir=${D}/usr/share/man install install-gzipped-man install-gzipped-info
    
    cd ${S}
    # Different format versions of the Allegro documentation
    dodoc allegro.dvi allegro.ps allegro.txt 
    
}

